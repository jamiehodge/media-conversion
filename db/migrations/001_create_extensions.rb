Sequel.migration do
  up do
    run "CREATE EXTENSION citext"
    run "CREATE EXTENSION moddatetime"
    run 'CREATE EXTENSION "uuid-ossp"'

    create_notification_function
  end

  down do
    drop_function :notify

    run 'DROP EXTENSION "uuid-ossp"'
    run "DROP EXTENSION moddatetime"
    run "DROP EXTENSION citext"
  end
end
