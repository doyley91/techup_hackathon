import streamlit as st

# Set page title
st.set_page_config(page_title="Hello World App", page_icon="👋")

# Main title
st.title("👋 Hello World!")

# Subtitle
st.subheader("Welcome to your first Streamlit app")

# Some text
st.write("This is a simple hello world application built with Streamlit.")

# Add some interactive elements
st.write("---")
st.write("### Interactive Elements")

# Text input
name = st.text_input("What's your name?", placeholder="Enter your name here...")

if name:
    st.write(f"Hello, {name}! 🎉")

# Button
if st.button("Click me!"):
    st.balloons()
    st.success("You clicked the button! 🎈")

# Slider
age = st.slider("How old are you?", 0, 100, 25)
st.write(f"You are {age} years old")

# Selectbox
favorite_color = st.selectbox(
    "What's your favorite color?",
    ["Red", "Blue", "Green", "Yellow", "Purple"]
)
st.write(f"Your favorite color is {favorite_color}") 