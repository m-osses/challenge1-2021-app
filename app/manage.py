from flask.cli import FlaskGroup

from app import app
cli = FlaskGroup(app)

if __name__ == '__main__':
    cli()


# Follow these commands to migrate your database
# python3 manage.py db init
# python3  manage.py db migrate
# python3 manage.py db upgrade
