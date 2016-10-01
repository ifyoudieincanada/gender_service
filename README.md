# GenderService
The GenderService associates Users with Genders.

Tables:

  * Genders
      The Genders table contains a set of genders that are dynamically-creatable
      by a User. The columns for the Genders table are as follows:

      `name`, the name of the gender, can be NULL
      `nominative`, the Nominative pronoun, He/She/Ae
      `accusative`, the Accusative pronoun, Him/Her/Aer
      `pronomial_possessive`, the Pronomial Possessive pronoun, His/Her/Aer
      `predicative_possessive`, the Predicative Possessive pronoun, His/Hers/Aers
      `reflexive`, the Reflexive pronoun, Himself/Herself/Aerself

      The Genders table has a `has_many` relationship with the Users table.

      The Genders table has a unique constraint across all the keys, so there
      cannot be duplicate genders.

      By allowing users to create their own genders, we will get submissions such as
      `Apache Attack Helicopter`, and `FuckGender`. This is fine by me tbh.
  * Users
      The Users table is a map of user_id to gender using foreign keys

      Columns: `user_id`

      `belongs_to` Genders

Endpoints:

  * GET /genders
      A list of all created Genders without references to Users.
  * POST /genders/create
      The URL used to create Genders.
  * GET /genders/:gender_id
      Retrieves pronouns for the Gender.
  * PUT /genders/:gender_id
      The URL used to assign Users to Gender.
      ```elixir
      payload = %{
        "user_id" => 123,
      }
      ```

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
