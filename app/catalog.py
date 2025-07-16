from pyiceberg.catalog.hive import HiveCatalog
from pyiceberg.io.pyarrow import PyArrowFileIO
from settings import settings

def get_catalog():
    s3_properties = {
        's3.endpoint': settings.S3_ENDPOINT,
        's3.access-key-id': settings.S3_ACCESS_KEY,
        's3.secret-access-key': settings.S3_SECRET_KEY,
        's3.path-style-access': 'true',
        's3.region': settings.S3_REGION,
    }

    file_io = PyArrowFileIO(properties=s3_properties)

    return HiveCatalog(
        name='default',
        uri=settings.HIVE_URI,
        warehouse=settings.S3_BUCKET,
        file_io=file_io,
        **s3_properties,
    )
