const AWS = require("aws-sdk");

const s3 = new AWS.S3();

exports.handler = async (event) => {

    console.log("CloudSync File Processing Started");

    const processedBucket = process.env.PROCESSED_BUCKET;

    const allowedExtensions = [
        "pdf",
        "jpg",
        "jpeg",
        "png",
        "docx",
        "txt"
    ];

    try {

        for (const record of event.Records) {

            const sourceBucket = record.s3.bucket.name;

            const objectKey = decodeURIComponent(
                record.s3.object.key.replace(/\+/g, " ")
            );

            console.log("Uploaded File:", objectKey);

            const extension = objectKey.split(".").pop().toLowerCase();

            if (!allowedExtensions.includes(extension)) {

                console.log("Unsupported file type:", extension);

                continue;

            }

            const metadata = await s3.headObject({
                Bucket: sourceBucket,
                Key: objectKey
            }).promise();

            console.log("File Size:", metadata.ContentLength);
            console.log("Content Type:", metadata.ContentType);

            const timestamp = Date.now();

            const newFileName = `${timestamp}-${objectKey}`;

            await s3.copyObject({
                Bucket: processedBucket,
                CopySource: `${sourceBucket}/${objectKey}`,
                Key: newFileName
            }).promise();

            console.log("Copied to Processed Bucket");

            await s3.deleteObject({
                Bucket: sourceBucket,
                Key: objectKey
            }).promise();

            console.log("Original File Deleted");

        }

        console.log("CloudSync Processing Completed");

        return {
            statusCode: 200,
            body: "Success"
        };

    }
    catch (error) {

        console.error(error);

        return {
            statusCode: 500,
            body: error.message
        };

    }

};