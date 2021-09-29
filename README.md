## iOS Bootcamp Challenge

This is a challenge to be solved in order to be an attendee in the Wizeline
Academy's iOS Bootcamp! But don't worry, you won't face some complex algorithms nor
tricky questions about complexity. :) Instead, you'll have to solve a series of tasks
regarding the basic principles of the iOS Development.

What we have here is a little Pokedex app (which uses the famous [PokeAPI](https://pokeapi.co/)).

The topics covered by the challenge are:

### Networking & Data
 
The `ListViewController` contains a collections of `PokeCells` which will display a list of Pokemons
to the user. You'll need to handle the `PokeApi` to retrieve each Pokemon details.

### Concurrency
Requests in the project take different times to return data! Make sure you are finish downloading
all pokemons before updating the `CollectionView`


### Patterns and Architecture

To display more info about a Pokemon we provided a `SearchBar` and `DetailViewController` objects, 
however they are not in used yet! You need to implement them and handle the navigation 
to allow the user search and select a Pokemon from the `ListViewController` to display it in detail.

You can encapsulate your components in the same file or create more files in the project.

### Views & Layouts
Let's display the Pokemons details like the image, type and attacks. What ever you wanna display 
We provided a start ui using Layout Constraints in the code, but feel free to use Frames or the Storyboard!

#### Extras
If you have time left address the extra TODO's inside the project to show off your skill!

## Code Review Process

You'll receive this challenge as a zip file, with no git repo available. To start solving
the challenge, you'll need to follow the next steps:

1. When you receive the challenge, create a git repo to track their solutions (use the command `$ git init`).
2. Solve the challenges, creating a commit for every exercise.
3. When everything is ready, create a **private** repo on Github and push your code.
4. Add your mentor as a contributor, so they can check your code.
