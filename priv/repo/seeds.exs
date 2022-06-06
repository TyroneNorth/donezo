# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Donezo.Repo.insert!(%Donezo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


Donezo.Repo.insert!(%Donezo.Accounts.User{
  email: "test@test.com", password: "passwordisLong1!", hashed_password: Pbkdf2.hash_pwd_salt("passwordisLong1!")}
)

Donezo.Repo.insert!(%Donezo.Notes.Task{
  title: "First Tasks!", items: ["Create a new task. Click the 'NEW TASK' button near the top of the screen.", "Delete this item."], user_id: 1})

Donezo.Repo.insert!(%Donezo.Notes.Task{
  title: "Second Tasks!", items: ["Edit this task. Change the title and add or remove items", "You can add as many items as you like."], user_id: 1})
