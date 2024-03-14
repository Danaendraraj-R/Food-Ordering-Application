const restaurantsElem = document.querySelector('.restaurants');
const inputBox = document.getElementById('search');
const errorMessage = document.querySelector('.errorNotify');
const loginButton = document.getElementById('loginButton');
const signupButton = document.getElementById('signupButton');
const usernameDisplay = document.getElementById('usernameDisplay');

let hotelLists = [];

$.ajax({
    url: "RestaurantData",
    type: "GET",
    dataType: "json",
    success: function (responsedata) {
        hotelLists = responsedata;
        displayRestaurantData(hotelLists);
    
    },
    error: function (xhr, status, error) {
        console.log("Error fetching restaurant data:");
        console.log("Status: " + status);
        console.log("Error message: " + error);
        console.log("Response Text: " + xhr.responseText);
    }
});



function displayRestaurantData(data) {
    var restaurantsElem = $(".restaurants");
    restaurantsElem.empty();

    if (data.length === 0) {
        restaurantsElem.append("<p>No restaurants available</p>");
    } else {
        var restaurantList = data.map(restaurant => getRestaurantCard(restaurant));
        restaurantsElem.append(restaurantList);
    }
}

function getRestaurantCard(restaurant) {
    return `
        <div class='restaurant-card' onclick="showDishes(${restaurant.id})">
        <div class='restaurant-image'>
        <img src=${restaurant.img} />
              </div>
            <div class="restaurant-description">
                <div class="restaurant-name">${restaurant.name}</div>
                <div class="restaurant-tags">${restaurant.tag1}, ${restaurant.tag2}</div>
                <div style="padding: 0 10px;">
                    <span class="restaurant-location">${restaurant.location}</span><br>
                    <span class="restaurant-rating">Rating:${restaurant.rating}</span><br>
                    <span class="restaurant-eta">ETA:${restaurant.eta} Mins</span>
                </div>
            </div>
        </div>
    `;
}

function showDishes(restaurantId) {
    window.location.href = `dishes.html?restaurantId=${restaurantId}`;
}

const generateRestaurantList = data => data.map(restaurant => getRestaurantCard(restaurant));

const searchResult = () => {
    let filteredList = hotelLists.filter(restaurant => {
        const tags = restaurant.tags ? restaurant.tags.toString().toLowerCase() : '';
        const name = restaurant.name ? restaurant.name.toString().toLowerCase() : '';

        return tags.indexOf(inputBox.value.toLowerCase()) > -1 || name.indexOf(inputBox.value.toLowerCase()) > -1;
    });
    restaurantsElem.innerHTML = (filteredList.length == 0) ? "No Results Found !!" : generateRestaurantList(filteredList).join('');
}

// debouncing
let debounce = (fn, delay) => {
    let timeout;
    return function () {
        clearTimeout(timeout);
        timeout = setTimeout(() => fn(), delay)
    }
}
let search = debounce(searchResult, 400);

document.addEventListener('input', search);

const sortby = e => {
    if (e.target.value == 'rating') {
        let sortByRatingList = hotelLists.sort((a, b) => b.rating - a.rating);
        restaurantsElem.innerHTML = generateRestaurantList(sortByRatingList).join('');
    } else if (e.target.value == 'eta') {
        let sortByETAList = hotelLists.sort((a, b) => a.eta - b.eta);
        restaurantsElem.innerHTML = generateRestaurantList(sortByETAList).join('');
    }
}
