from robot.api.deco import keyword
from pymongo import MongoClient
import certifi

client = MongoClient('mongodb+srv://alinedias:teste@cluster0.ms3rf5r.mongodb.net/?retryWrites=true&w=majority')

db = client['markdb']

@keyword('Remove user from database')
def remove_user(email):
        users = db['users']
        users.delete_many({'email': email})
        print('removing user by '+email)

@keyword('Insert user from database')
def insert_user(user):
        #doc = {
        #        'name': name,
        #        'email': email,
        #        'password': password
        #}

        users = db['users']
        users.insert_one(user)
        print(user)