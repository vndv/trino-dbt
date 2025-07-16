import os
from pathlib import Path
from dotenv import load_dotenv
from pydantic_settings import BaseSettings

# Загружаем .env файл из корня проекта
dotenv_path = Path(__file__).parent.parent / '.env'
load_dotenv(dotenv_path=dotenv_path)

class AppSettings(BaseSettings):
    ENV: str = os.getenv('ENV', 'dev')
    HIVE_URI: str = os.getenv('HIVE_URI', '')
    S3_ENDPOINT: str = os.getenv('S3_ENDPOINT', '')
    S3_ACCESS_KEY: str = os.getenv('S3_ACCESS_KEY', '')
    S3_SECRET_KEY: str = os.getenv('S3_SECRET_KEY', '')
    S3_BUCKET: str = os.getenv('S3_BUCKET', '')
    S3_REGION: str = os.getenv('S3_REGION', 'us-east-1')

settings = AppSettings()
