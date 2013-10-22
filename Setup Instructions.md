
*Type the commands in the blocks into your terminal/command window*

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
8. Install the required libraries for the project
    `bundle install`
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