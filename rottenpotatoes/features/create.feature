Feature: create new movies

  As a movie buff
  So that I can create new movies 
  I want to be able to add a new movie

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: add a movie to existing database
  Given I am on the home page
  When I follow "Add new movie"
  And I fill in "Title" with "Indiana Jones"
  When I press "Save Changes"
  Then I should be on the home page
  