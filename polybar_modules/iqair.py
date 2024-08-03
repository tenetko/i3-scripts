import json

import requests

from common import CommonData


class IqAirModule:

    API_KEY = "API_KEY"
    URL_GEO = "http://api.airvisual.com/v2/nearest_city?key={api_key}"
    URL_GPS = "http://api.airvisual.com/v2/nearest_city?lat={lat}&lon={lon}&key={api_key}"

    def get_gps_data(self, city):
        res = requests.get(self.URL_GPS.format(lat=city["lat"], lon=city["lon"], api_key=self.API_KEY))

        return res.text

    def get_aqius(self, res):
        res = json.loads(res)
        aqius = int(res["data"]["current"]["pollution"]["aqius"])

        return aqius

    def run(self):
        res = self.get_gps_data(CommonData.CURRENT_CITY)
        aqius = self.get_aqius(res)
        print(aqius)


if __name__ == "__main__":
    m = IqAirModule()
    m.run()
