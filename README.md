## iOS Bootcamp Challenge

You must solve this challenge in order to be an attendee in the Wizeline
Academy's iOS Bootcamp! But don't worry, you won't face any complex algorithms nor tricky questions about complexity. :) 
Instead, you'll have to solve a series of tasks regarding the basic principles of iOS Development.

What we have here is a little Pokedex app (which uses the famous [PokeAPI](https://pokeapi.co/)).

The topics covered by the challenge are:

### Networking & Data
 
The `ListViewController` contains a collection of `PokeCell` which display a list of Pokemons to the user.
You need to handle the PokeApi to retrieve each Pokemon detail.

    // TODO: Implements generics to merge this methods into one
    // TODO: Decode list of types & abilities


### Concurrency
Requests in the project take different times to return data!
Make sure you are finished downloading all pokemons before updating the `CollectionView`

    // TODO: Wait for all requests to finish before updating the collection view


### Patterns and Architecture

To display more info about a Pokemon we provided a `SearchBar` and `DetailViewController` objects, 
however, they are not in use yet! You need to implement them and handle the navigation 
to allow the user to search and select a Pokemon from the ListViewController to display it in detail.

You can encapsulate your components in the same file or create more files in the project.

    // TODO: Handle navigation to detail view controller


### Views & Layouts
Let's display the Pokemons details like the image, type, and attacks. Whatever you wanna display.
We provided a start UI using Layout Constraints in the code, but feel free to use Frames or the Storyboard!

    // TODO: Display pokemon info (eg. types, abilities)


#### Extras
If you have time left address the extra TODO's inside the project to show off your skills!
    
    // TODO: Implement the SearchBar
    // TODO: Use UserDefaults to pre-load the latest search at start
    // TODO: Add a loading indicator when the app first launches and has no pokemons


## Code Review Process

You'll receive this challenge as a zip file, with no git repo available. After you receive it, take the following steps to resolve it:

1. Create a git repo to track your solutions (use the command `$ git init`).
2. Solve the challenges, creating a commit for every exercise.
3. After you complete the challenges, create a private repo on Github and push your code.
4. Add your mentor as a contributor, so they can check your code.
