from typing import Dict, Generator, List

import requests


class RestAdapter:
    BASE_URL = "https://jaffle-shop.scalevector.ai/api/v1/"

    def _generate_endpoint(self, endpoint: str):
        return self.BASE_URL + endpoint

    def get_data(self, endpoint: str) -> Generator[List[Dict[str, str]]]:
        full_url = self._generate_endpoint(endpoint)
        response = requests.get(url=full_url)
        data_out = response.json()
        yield from data_out
