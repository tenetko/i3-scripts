import json

import requests

from common import CommonData


class OpenWeatherMapModule:
    API_KEY = "API_KEY"
    WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?units=metric&lat={lat}&lon={lon}&appid={api_key}"
    ICONS = {
        "01d": "",
        "01n": "",
        "02d": "",
        "02n": "",
        "03d": "",
        "03n": "",
        "04d": "",
        "04n": "",
        "09d": "",
        "09n": "",
        "10d": "",
        "10n": "",
        "11d": "",
        "11n": "",
        "13d": "",
        "13n": "",
        "50d": "",
        "50n": "",
    }

    def get_current_weather(self, city: dict) -> str:
        try:
            res = requests.get(self.WEATHER_URL.format(lat=city["lat"], lon=city["lon"], api_key=self.API_KEY))
            res = res.text
        except requests.exceptions.ConnectionError:
            res = ""

        return res

    def parse_weather(self, res: str) -> str:
        if res == "":
            result = "--°/--°  --  --"
            return result

        res = json.loads(res)
        temperature = int(round(res["main"]["temp"], 0))
        feels_like = int(round(res["main"]["feels_like"], 0))
        pressure = res["main"]["pressure"]
        humidity = res["main"]["humidity"]
        icon = res["weather"][0]["icon"]
        result = f"{self.ICONS[icon]} {temperature}°/{feels_like}°  {humidity}  {pressure}"

        return result

    def run(self):
        res = self.get_current_weather(CommonData.CURRENT_CITY)
        print(self.parse_weather(res))


if __name__ == "__main__":
    m = OpenWeatherMapModule()
    m.run()
