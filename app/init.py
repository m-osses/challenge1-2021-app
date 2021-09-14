from flask import Flask
from flask_migrate import Migrate

from models import db
import config

migrate = Migrate()

def create_app():
    flask_app = Flask(__name__)
    flask_app.config['SQLALCHEMY_DATABASE_URI'] = config.DATABASE_CONNECTION_URI
    flask_app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    flask_app.app_context().push()
    db.init_app(flask_app)
    migrate.init_app(flask_app, db)
    db.create_all()
    return flask_app
