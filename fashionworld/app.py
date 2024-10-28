from flask import Flask, render_template, redirect, url_for, session, flash, request
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired
import bcrypt
from flask_mysqldb import MySQL

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'fashionworld'
app.secret_key = 'your_secret_key_here' #your secret_key here

mysql = MySQL(app)

class RegistrationForm(FlaskForm):
    name = StringField('name', validators=[DataRequired()])
    email = StringField('email', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])
    submit = SubmitField("register")

class LoginForm(FlaskForm):
    email = StringField('email', validators=[DataRequired()])
    password = PasswordField('password', validators=[DataRequired()])
    submit = SubmitField("login")

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/index')
def homepage():
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        name = form.name.data
        email = form.email.data
        password = form.password.data
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO users (name, email, password) VALUES (%s, %s, %s)", (name, email, hashed_password))
        mysql.connection.commit()
        cursor.close()

        return redirect(url_for('login'))

    return render_template('register.html', form=form)

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        email = form.email.data
        password = form.password.data

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT * FROM users WHERE email=%s", (email,))
        user = cursor.fetchone()

        if user and bcrypt.checkpw(password.encode('utf-8'), user[3].encode('utf-8')):
            session['user_id'] = user[0]
            return redirect(url_for('collection'))
        else:
            flash("Login Failed. Try again with a valid password")

        cursor.close()

    return render_template('login.html', form=form)

@app.route('/collection')
def collection():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM products")
    rows = cursor.fetchall()
    cursor.close()

    # Convert rows to a list of dictionaries
    products = []
    for row in rows:
        product = {
            "id": row[0],
            "name": row[1],
            "image_url": row[2],
            "price": row[3],
            "description": row[4]
        }
        products.append(product)

    return render_template('collection.html', products=products)

@app.route('/add_to_cart', methods=['POST'])
def add_to_cart():
    product_id = request.form.get('product_id')
    
    if 'cart' not in session:
        session['cart'] = []
    
    session['cart'].append(product_id)
    session.modified = True  # Indicate that the session has been modified
    
    flash("Your item has been added to the cart!", "success")
    return redirect(url_for('collection'))

@app.route('/remove_from_cart', methods=['POST'])
def remove_from_cart():
    product_id = request.form.get('product_id')
    
    if 'cart' in session:
        session['cart'] = [item for item in session['cart'] if item != product_id]
    
    flash("Item removed from cart!", "success")
    return redirect(url_for('cart'))

@app.route('/cart')
def cart():
    cart_items = session.get('cart', [])
    
    cursor = mysql.connection.cursor()
    # Fetch products that are in the cart
    cursor.execute("SELECT * FROM products WHERE id IN %s", (tuple(cart_items),))
    products = cursor.fetchall()
    cursor.close()
    
    return render_template('cart.html', products=products)

@app.route('/checkout')
def checkout():
    return render_template('checkout.html')

@app.route('/aboutus')
def aboutus():
    return render_template('aboutus.html')

if __name__ == '__main__':
    app.run(debug=True)
