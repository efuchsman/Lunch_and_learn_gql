<h1 align="center">Lunch and Learn GraphQL</h1>

<br />
<div align="center">
  <a href="https://github.com/efuchsman/lunch-and-learn">
    <img src="https://robbreport.com/wp-content/uploads/2018/12/edit-PLAT-EUG-174-YOAN-CHEVOJON.jpg" alt="The cuisine of Michel Guérard." width="650" height="450">
  </a>

  <h3 align="center">
    Get recipes for a country as well as learn about that country!
    <br />
  </h3>
</div>

# Table of Contents
* [App Description](#app-description)
* [Learning Goals](#learning-goals)
* [System Requirements](#system-requirements)
* [Technologies Used](#technologies-used)
* [Setup](#setup)
* [Respository](#repository)
* [Endpoints](#endpoints)

# App Description
 This app allows users to search for recipes by country, favorite recipes, and learn more about a particular country.

# Learning Goals
* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
* Build with GraphQL

# System Requirements
* Ruby 2.7.4
* Rails 5.2.8

# Technologies Used 

![Ruby on Rails](	https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=ffffff&color=CC0000)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-008bb9?style=for-the-badge&logo=PostgreSQL&logoColor=ffffff&color=008bb9)
![Graphql](https://img.shields.io/badge/Graphql-ffffff?style=for-the-badge&logo=graphql&logoColor=e535ab&color=ffffff)
![Docker](https://img.shields.io/badge/Docker-ffffff?style=for-the-badge&logo=docker&logoColor=ffffff&color=0db7ed)
![Git](https://img.shields.io/badge/Github_Actions-100?style=for-the-badge&logo=GitHub&logoColor=ffffff&color=141422)


# Repository

https://github.com/efuchsman/Lunch_and_learn_gql

## Setup
1. Fork and Clone the repository
2. Install gem packages: `bundle install`
3. Setup Figaro: `bundle exec figaro install`
4. Setup the database: `rails db:{drop,create,migrate,seed}`
5. Sign up for an api key and app id through edamame: https://developer.edamam.com/edamam-recipe-api
6. In application.yml: `edamam_api_key: <YOUR KEY> edamam_app_id: <YOUR ID>`
7. Sign up for an api key for youtube: https://developers.google.com/youtube/v3/getting-started
8. In application.yml: `YOUTUBE_API_KEY: <YOUR KEY>`
9. Sign up for api key with Unsplash: https://unsplash.com/developers
10. In application.yml: `unsplash_access_key: <YOUR KEY>`
11. All 48 tests should be passing with 100% coverage: `bundle exec rspec`
12. Run the server `rails s`

<h3>Setup for Docker</h3>

1. Fork and Clone the repository
2. Open Docker Desktop and sign in
3. Builder docker image and launch server container: `docker-compose up --build` (You will only have to run `docker-compose up` after this unless you pull a newly updated version of the repository from GitHub)
4. Migrate the database: `docker-compose exec web bundle exec rake db:migrate`
5. Seed data: `docker-compose exec web bundle exec rake db:seed`
6. To close the the container: `Ctrl-C`
7. If you need to drop the database and reseed data: `docker-compose down --volumes`

# Endpoints

In your browser: http://localhost:3000/graphiql

## Rest Countries

### GET restCountries

#### Request:

```
{
  restCountries{
    name
    capital
  }
}
```

#### Response:

```
{
  "data": {
    "restCountries": [
      {
        "name": "Barbados",
        "capital": "Bridgetown"
      },
      {
        "name": "Réunion",
        "capital": "Saint-Denis"
      },
      {..},
      {..},
     ]
   }
 }

```

### GET randomRestCountry

#### Request:

```
{
  randomRestCountry{
    name
    capital
  }
}
```

#### Response:

```
{
  "data": {
    "randomRestCountry": {
      "name": "Guernsey",
      "capital": "St. Peter Port"
    }
  }
}
```

## Recipes

### GET recipes 

#### Request:

```
{
  recipes(country: "Mexico"){
    title
    url
    image
    country
  }
}
```

#### Response:

```
{
  "data": {
    "recipes": [
      {
        "title": "Avocado from Mexico, Orange and Watercress Salad. Adapted from Chef Richard Sandoval, New York, Mexico and Dubai",
        "url": "https://food52.com/recipes/5794-avocado-from-mexico-orange-and-watercress-salad-adapted-from-chef-richard-sandoval-new-york-mexico-and-dubai",
        "image": "https://edamam-product-images.s3.amazonaws.com/web-img/7a0/7a0ce2ee688b9534b92257c4c1f13b95.JPG?X-Amz-Security-Token=IQoJb3JpZ2lu...",
        "country": "Mexico"
      },
      {
        "title": "New Mexico Chile-Glazed Chicken On Hominy Polenta",
        "url": "http://www.bonappetit.com/recipes/quick-recipes/2008/12/new_mexico_chile_glazed_chicken",
        "image": "https://edamam-product-images.s3.amazonaws.com/web-img/393/393b5c81ae860fee33d0a1878c4c4b75.jpg?X-Amz-Security-Token=IQoJb3JpZ2lu...",
        "country": "Mexico"
      },
      {
        "title": "New Mexico Chile Sauce",
        "url": "http://www.eatingwell.com/recipe/248399/new-mexico-chile-sauce/",
        "image": "https://edamam-product-images.s3.amazonaws.com/web-img/4eb/4eb6605a116f1ff98bd8cf22237e24e0.jpg?X-Amz-Security-Token=IQoJb3JpZ2l...",
        "country": "Mexico"
      },
      {
        "title": "Homemade Fresh Chorizo",
        "url": "https://www.epicurious.com/recipes/food/views/homemade-fresh-chorizo-395919",
        "image": "https://edamam-product-images.s3.amazonaws.com/web-img/206/20669e3ae301c2f766d35a1ae711be90.jpg?X-Amz-Security-Token=IQoJb3JpZ2l....",
        "country": "Mexico"
      },
     {...},
     {...},
     {...},
    ]
  }
}
```

## Learning Resources

### GET learningResource

#### Request: 

```
{
  learningResource(country: "Portugal"){
    country
    video {
      title
      youtubeVideoId
    }
    images {
      altTag
      url
    }
  }
}
```

Response:

```
{
  "data": {
    "learningResource": {
      "country": "Portugal",
      "video": {
        "title": "A Super Quick History of Portugal",
        "youtubeVideoId": "nQh6V8adGXw"
      },
      "images": [
        {
          "altTag": "boats docked near seaside promenade]",
          "url": "https://images.unsplash.com/photo-1555881400-74d7acaacd8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTk0NjN8MHwxfHNlYXJjaHwxfHxQb3J0dWdhbHxlbnwwfHx8fDE2ODA2Mjg4NDk&ixlib=rb-4.0.3&q=80&w=1080"
        },
        {
          "altTag": "landscape photography of orange roof houses near body of water",
          "url": "https://images.unsplash.com/photo-1536663815808-535e2280d2c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTk0NjN8MHwxfHNlYXJjaHwyfHxQb3J0dWdhbHxlbnwwfHx8fDE2ODA2Mjg4NDk&ixlib=rb-4.0.3&q=80&w=1080"
        },
        {...},
        {...},
        {...},
        {...}
      ]
    }
  }
}
```

## Users

### POST createUser

Request: 

```
mutation {
	createUser(input: {params: { name: "Eli Fuchsman", email: "elif@mail.com"}}){
    user {
      id
      name
      email
      apiKey
    }
  }
}
```

Response:

```
{
  "data": {
    "createUser": {
      "user": {
        "id": "4",
        "name": "Eli Fuchsman",
        "email": "elif@mail.com",
        "apiKey": "29fa7c8b95df8fa19b6cde918b48fc66"
      }
    }
  }
}
```

### GET user

#### Request:

```
{
  user(apiKey: "29fa7c8b95df8fa19b6cde918b48fc66"){
    id
    name
    email
    apiKey
    favorites{
      id
      country
      recipeTitle
      recipeLink
    }
  }
}
```

#### Response:

```
{
  "data": {
    "user": {
      "id": "4",
      "name": "Eli Fuchsman",
      "email": "elif@mail.com",
      "apiKey": "29fa7c8b95df8fa19b6cde918b48fc66",
      "favorites": []
    }
  }
}
```

## Favorites

### POST createFavorite

#### Request: 

```
mutation {
  createFavorite(input: {params: {country: "USA", recipeTitle: "72oz Tomahawk Ribeye", recipeLink: "https://www.somelink.com"}, apiKey:"29fa7c8b95df8fa19b6cde918b48fc66"}){
    favorite {
      id
      country
      recipeTitle
      recipeLink
      userId
    }
    success
  }
}
```

#### Response: 

```
{
  "data": {
    "createFavorite": {
      "favorite": {
        "id": "7",
        "country": "USA",
        "recipeTitle": "72oz Tomahawk Ribeye",
        "recipeLink": "https://www.somelink.com",
        "userId": 4
      },
      "success": "New favorite created"
    }
  }
}
```

#### Now when the check the User again:

```
{
  user(apiKey: "29fa7c8b95df8fa19b6cde918b48fc66"){
    id
    name
    email
    apiKey
    favorites{
      id
      country
      recipeTitle
      recipeLink
    }
  }
}
```

#### Response: 

```
{
  "data": {
    "user": {
      "id": "4",
      "name": "Eli Fuchsman",
      "email": "elif@mail.com",
      "apiKey": "29fa7c8b95df8fa19b6cde918b48fc66",
      "favorites": [
        {
          "id": "7",
          "country": "USA",
          "recipeTitle": "72oz Tomahawk Ribeye",
          "recipeLink": "https://www.somelink.com"
        }
      ]
    }
  }
}
```

### DESTROY deleteFavorite

#### Request:

```
mutation {
  deleteFavorite(input: {id: 7, apiKey: "29fa7c8b95df8fa19b6cde918b48fc66"}) {
    success
  }
}
```

### Response:

```
{
  "data": {
    "deleteFavorite": {
      "success": "Favorite successfully deleted"
    }
  }
}
```

#### Now when the check the User again:

```
{
  user(apiKey: "29fa7c8b95df8fa19b6cde918b48fc66"){
    id
    name
    email
    apiKey
    favorites{
      id
      country
      recipeTitle
      recipeLink
    }
  }
}
```

#### Response:

```
{
  "data": {
    "user": {
      "id": "4",
      "name": "Eli Fuchsman",
      "email": "elif@mail.com",
      "apiKey": "29fa7c8b95df8fa19b6cde918b48fc66",
      "favorites": []
    }
  }
}
```


## Contact 

<table align="center">
  <tr>
    <td><img src="https://avatars.githubusercontent.com/u/104859844?s=150&v=4"></td>
  </tr>
  <tr>
    <td>Eli Fuchsman</td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/efuchsman">GitHub</a><br>
      <a href="https://www.linkedin.com/in/elifuchsman/">LinkedIn</a>
    </td>
  </tr>
</table>



<!-- ACKNOWLEDGEMENTS -->
<h3><b>Acknowledgements</b></h3>

Turing School of Software Design: [https://turing.edu/](https://turing.edu/)

Original Lunch and Learn Project: [https://github.com/efuchsman/lunch-and-learn](https://github.com/efuchsman/lunch-and-learn)

<p>Image Source:</p>
<p> https://robbreport.com/wp-content/uploads/2018/12/edit-PLAT-EUG-174-YOAN-CHEVOJON.jpg </p>
