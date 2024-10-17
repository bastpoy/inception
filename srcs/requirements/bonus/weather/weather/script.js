import fetch from "node-fetch";

const API_KEY = "d5fc3a85c073273f060229b6185e7a1b"; // Replace with your OpenWeather API key
const cities = ['Lyon', 'London', 'New York', 'Tokyo', 'Paris', 'Berlin', 'Sydney', 'Moscow', 'Rio de Janeiro', 'Cape Town', 'Mumbai'];

function getRandomCity() {
    const randomIndex = Math.floor(Math.random() * cities.length);
    return cities[randomIndex];
}

async function getWeatherForRandomCity() {
    const city = getRandomCity();
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric`;

    try {
        const response = await fetch(url);
        const data = await response.json();
        if (data.main && data.main.temp) {
            return {
                city: city,
                temperature: data.main.temp
            };
        } else {
            throw new Error('Temperature data not found');
        }
    } catch (error) {
        console.error('Error fetching weather data:', error);
        return null;
    }
}

// Example usage:
async function  main() {
    while (true) {
        const result = await getWeatherForRandomCity();
        if (result) {
            console.log(`The temperature in ${result.city} is ${result.temperature}°C`);
        }
        await new Promise(resolve => setTimeout(resolve, 5000)); // Wait for 5 seconds before the next request
    }
}
main();
