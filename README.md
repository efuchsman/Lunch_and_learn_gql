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

# Technology Used: 

![Ruby on Rails](	https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=7b95ad&color=141422)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-100?style=for-the-badge&logo=PostgreSQL&logoColor=7b95ad&color=141422)
![Graphql](https://img.shields.io/badge/Graphql-100?style=for-the-badge&logo=graphql&logoColor=7b95ad&color=141422)
![Docker](https://img.shields.io/badge/Docker-100?style=for-the-badge&logo=docker&logoColor=7b95ad&color=141422)


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

# Endpoints

In your browser: http://localhost:3000/graphiql

## Recipes

### GET /api/v1/recipes?country=thailand

Response:

```
  {
     "data": [
        {
          "id": null,
          "type": "recipe",
          "attributes": {
          "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
          "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
          "country": "Thailand",
          "image": "https://edamam-product-images.s3.amazonaws.com/web-img/611/61165abc1c1c6a185fe5e67167d3e1f0.jpg?..."
         }
        },
      {...},
      {...},
      ]
  }
```

## Learning Resources

### GET /api/v1/learning_resources?country=belgium

Respone:

```
{
   "data": {
      "id": null,
      "type": "learning_resource",
      "attributes": {
         "country": "Belgium",
         "video": {
            "title": "A Super Quick History of Belgium",
            "youtube_video_id": "R6-eMN5En4g"
          },
          "images": [
              {
                  "alt_tag": "assorted-color of houses near lake",
                  "url": "https://images.unsplash.com/photo-1491557345352-5929e343eb89?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTk0NjN8MHwxfHNlYXJjaHwxfHxCZWxnaXVtfGVufDB8fHx8MTY3NzUzOTg0Mg&ixlib=rb-4.0.3&q=80&w=1080"
              },
              {
                  "alt_tag": "gray and brown building under blue sky",
                  "url": "https://images.unsplash.com/photo-1461838239441-4475121c0b7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTk0NjN8MHwxfHNlYXJjaHwyfHxCZWxnaXVtfGVufDB8fHx8MTY3NzUzOTg0Mg&ixlib=rb-4.0.3&q=80&w=1080"
              },
          {...},
          {...},

              ]
          }
      }
  }
```

## Users
### POST /api/v1/users

Request: 
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "name": "Athena Dao",
  "email": "athenadao@bestgirlever.com"
}
```

Response:
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "name": "Athena Dao",
            "email": "athenadao@bestgirlever.com",
            "api_key": "7a631d2ff08b6e901d9f6ae426d803f6"
        }
    }
}
```

## Favorites

* User must include their api key as a paramater in order to create a new favorite recipe.

### POST /api/v1/favorites?

Request: 
```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
    "api_key": "7a631d2ff08b6e901d9f6ae426d803f6",
    "country": "united states",
    "recipe_link": "72oz Tomahawk Ribeye"
}
```

Response: 

```
{
    "success": "Favorite Added Successfully"
}
```

### GET /api/v1/favorites?api_key=*new user generated api key*

* User must include their api key as a paramater in order to see their favorite recipes

Response:

```
{
    "data": [
        {
            "id": "3",
            "type": "favorite",
            "attributes": {
                "recipe_title": "72oz Tomahawk Ribeye",
                "recipe_link": "https://www.somelink.com",
                "country": "Country",
                "created_at": "2023-01-18T01:39:21.964Z"
            }
        },
        {
            "id": "4",
            "type": "favorite",
            "attributes": {
                "recipe_title": "4lb Lobster",
                "recipe_link": "https://www.somelink.com",
                "country": "Country",
                "created_at": "2023-01-18T01:39:50.162Z"
            }
        },
        {
            "id": "5",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Foie Gras",
                "recipe_link": "https://www.somelink.com",
                "country": "Country",
                "created_at": "2023-01-18T01:40:06.913Z"
            }
        }
    ]
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

<p>Image Source:</p>
<p> https://robbreport.com/wp-content/uploads/2018/12/edit-PLAT-EUG-174-YOAN-CHEVOJON.jpg </p>
