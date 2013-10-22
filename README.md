TutorCollective
===

## Introduction

Tutor Collective is a collaborative project to build the world's best way to find great tutors. The project is sponsored by TechCareerHQ and is intended to enable people to learn web development by being a part of the building a great product. You don't need any prior programming experience to contribute, just a willingness to find the best solution to the problems that you encounter. Please follow the instructions below.

We hope to use this project to teach you how to become an engineer that can excel in a tech company.

## Getting Started
The following steps will help you get a version of the site running on your computer. You can use this to make changes and edit the code before submitting a new feature or bug fix to the repository.

*Type the command in the blocks into your terminal/command window*

#### Mac Instructions

1. Install RVM (Ruby Version Manager) type this in terminal: 

    `\curl -L https://get.rvm.io | bash)`
    `rvm get head && rvm reload`

    `rvm install 1.9.3`
    
    `rvm --default use 1.9.3`
    
2. [Install Git](http://git-scm.com/download/mac)
3. [Generate SSH Keys](https://help.github.com/articles/generating-ssh-keys#platform-mac)
4. [Create GitHub Account - Sign Up](https://github.com/)
5. [Add SSH Key to GitHub Account](https://help.github.com/articles/generating-ssh-keys#step-3-add-your-ssh-key-to-github)
6. Download the code (clone the repository): 

    `git clone git@github.com:techcareerhq/tutor-collective.git`

7. Move into the project directory
    `cd tutor-collective`
8. Set up database: `rake db:migrate`
9. Start the server: `rails s`
10. Navigate to the site in your browser: localhost:3000

#### Windows Instructions

1. [Install Ruby and Rails](http://installfest.railsbridge.org/installfest/windows)
2. In terminal (download the code): 

    `git clone git@github.com:techcareerhq/tutor-collective.git`

3. Go into the tutor-collective directory (in the command line):

    `cd tutor-collective`

4. Install gems: bundle install
5. Set up database: rake db:migrate 
6. Start the server: rails s
7. Navigate to the site in your browser: localhost:3000

#### IDE Instructions
You will be writing code using a text editor. We recommend [SublimeText](http://www.sublimetext.com/).

##Contribution Instructions
We do our best to fully describe the features and bug fixes that need to be implemented. If you have any questions about the specifics of a requirement, let us know.

1. Create a new branch on Github with the name of the feature or bug that your are working on [info here](https://github.com/blog/1377-create-and-delete-branches)
2. Checkout the code from this branch
3. Commit your code to the branch
4. Submit a pull request to the master branch

###Design Guidelines
The color palette for the overall site is available here: http://www.colourlovers.com/palette/3087487/BlueC 
We'll try to use these colors whenver possible. For calls to action or other elements that require a color outside of the palette, we'll defer to [Boostrap's default button styles](http://getbootstrap.com/2.3.2/base-css.html#buttons)

