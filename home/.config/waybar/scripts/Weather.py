#!/usr/bin/env python3
# originally from https://raw.githubusercontent.com/rxyhn/dotfiles/main/home/rxyhn/modules/desktop/waybar/scripts/waybar-wttr.py
# edited by: vahrina

from json import dumps
from datetime import datetime
from requests import get, RequestException

city = "Lahr, Germany"

WEATHER_CODES = {
    '113': '', '116': '󰖕', '119': '', '122': '', '143': '',
    '176': '', '179': '', '182': '', '185': '', '200': '⛈️',
    '227': '🌨️', '230': '🌨️', '248': '☁️', '260': '☁️', '263': '🌧️',
    '266': '🌧️', '281': '🌧️', '284': '🌧️', '291': '🌧️', '293': '🌧️',
    '296': '🌧️', '299': '🌧️', '302': '🌧️','305': '🌧️', '308': '🌧️',
    '311': '🌧️', '314': '🌧️', '317': '🌧️', '320': '🌨️', '323': '🌨️',
    '326': '🌨️', '329': '❄️', '332': '❄️', '335': '❄️', '338': '❄️',
    '350': '🌧️', '353': '🌧️', '356': '🌧️', '359': '🌧️', '362': '🌧️',
    '365': '🌧️', '368': '🌧️', '371': '❄️', '374': '🌨️', '377': '🌨️',
    '386': '🌨️', '389': '🌨️', '392': '🌧️', '395': '❄️'
}

def fetch_weather(city: str, timeout: int = 5) -> dict:
    try:
        return get(f"https://wttr.in/{city}?format=j1", timeout=timeout).json()
    except RequestException:
        return None

def row(label: str, value: str, width: int = 14) -> str:
    return f"{label.ljust(width)}{value}\n"

def col(value: str, width: int, align: str = "<") -> str:
    return f"{value:{align}{width}}"

def day_header(label: str, date: str, width: int = 32) -> str:
    title = f"[ {label} | {date} ]"
    return title + "\n" + "~" * width + "\n"

def format_time(time: str) -> str:
    return time.replace("00", "").zfill(2)

def format_temp(temp: str) -> str:
    return (temp + "°").ljust(3)

#def format_chances(hour: dict) -> str:
#    chances_map = {
#        "chanceoffog": "fog",
#        "chanceoffrost": "frost",
#        "chanceofovercast": "overcast",
#        "chanceofrain": "rain",
#        "chanceofsnow": "snow",
#        "chanceofsunshine": "sunshine",
#        "chanceofthunder": "thunder",
#        "chanceofwindy": "wind"
#    }
#    conditions = [f"{chances_map[k]} {hour[k]}%" for k in chances_map if int(hour[k]) > 0]
#    return ", ".join(conditions)

# uncomment the function above in addition to the tooltip for % output
# e.g. 82% overcast, 95% rain
# additionally remove/comment the function below
def format_chances(hour):
    return hour['weatherDesc'][0]['value']

def build_tooltip(weather: dict) -> dict:
    if not weather:
        return {"text": "?°C", "tooltip": "network err"}

    current = weather['current_condition'][0]
    tempint = int(current['FeelsLikeC'])
    extrachar = '+' if 0 < tempint < 10 else ''

    data = {}
    data['text'] = ' ' + WEATHER_CODES.get(current['weatherCode'], '❔') + f" {extrachar}{current['FeelsLikeC']}°"

    desc = current['weatherDesc'][0]['value'].lower()
    tooltip = row("condition", f"<b>{desc} {current['temp_C']}°</b>")
    tooltip += row("feels like", current['FeelsLikeC'] + "°")
    tooltip += row("wind", current['windspeedKmph'] + " km/h")
    tooltip += row("humidity", current['humidity'] + "%")

    for i, day in enumerate(weather['weather'][:2]):
        # tooltip += f"\n<b>{'>>> today, ' if i == 0 else '>>> tomorrow, '}{day['date']}</b>\n"
        # ^ original today/tomorrow
        label = "today" if i == 0 else "tomorrow"
        tooltip += "\n" + day_header(label, day['date'])
        tooltip += f"⬆️{day['maxtempC']}° ⬇️{day['mintempC']}° "
        tooltip += f"🌅{day['astronomy'][0]['sunrise']} 🌇{day['astronomy'][0]['sunset']}\n"

        for hour in day['hourly']:
            if i == 0 and int(format_time(hour['time'])) < datetime.now().hour - 2:
                continue
            #tooltip += f"{format_time(hour['time'])} " \
                       #f"{WEATHER_CODES.get(hour['weatherCode'], '❔')} " \
                       #f"{format_temp(hour['FeelsLikeC'])} " \
                       #f"{hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"
                # uncomment the tooltip above to include % of the conditions
                # then comment/remove the bottom tooltip
            tooltip += (
                    col(format_time(hour['time']), 3, "<") + " "
                    + col(WEATHER_CODES.get(hour['weatherCode'], '❔'), 2) + " "
                    + col(format_temp(hour['FeelsLikeC']), 3) + " "
                    + col(format_chances(hour), 0) + "\n"
                    )

    data['tooltip'] = tooltip
    return data

def main():
    weather = fetch_weather(city)
    data = build_tooltip(weather)
    print(dumps(data))

if __name__ == "__main__":
    main()
