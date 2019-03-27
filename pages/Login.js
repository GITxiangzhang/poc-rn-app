import React, {Component} from 'react';
import {Platform, ScrollView, StyleSheet, Text, View, Button, TextInput, TouchableHighlight,
  TouchableOpacity, TouchableNativeFeedback, TouchableWithoutFeedback} from 'react-native';
import { createAppContainer, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
import HomeScreen from './Home'

class Login extends Component {
  constructor (props) {
    super(props)
    this.state = {clickedTimes: 0}
    this.textInput = React.createRef()
    this.pwdInput = React.createRef()
    this.changeText = this.changeText.bind(this)
  }

  componentDidMount () {
    this.textInput.current.focus()
  }

  changeText () {
  }
  onPress = () => {
    this.props.navigation.dispatch(StackActions.reset({
      index: 0,
      actions: [
        NavigationActions.navigate({ routeName: 'Home' })
      ],
    }))
  }

  render () {
    return (
      <View style={styles.container}>
        <TextInput 
          autoCapitalize={"none"}
          ref={this.textInput} onChangeText={this.changeText} style={styles.input} placeholder="用户"></TextInput>
        <TextInput ref={this.pwdInput} style={styles.input} secureTextEntry={true} placeholder="密码"></TextInput>
        {/* <Button style={styles.button} color="red" title="登陆"></Button> */}
        {/* <TouchableHighlight
         style={styles.button}
        >
         <Button title="login" color="#fff" onPress={this.onPress}></Button>
        </TouchableHighlight> */}
        <TouchableHighlight
         style={styles.button}
         underlayColor="red"
         onPress={this.onPress}>
          <Text style={styles.text}>Login</Text>
        </TouchableHighlight>
        {/* <ScrollView>
        <TouchableOpacity
         style={styles.button}
         underlayColor="yellow"
         onPress={this.onPress}>
          <Text style={styles.text}>TouchableOpacity</Text>
        </TouchableOpacity>
        <TouchableWithoutFeedback
          style={styles.button}>
          <View style={styles.button}>
          <Text style={styles.text}>TouchableWithoutFeedback</Text>
          </View>
        </TouchableWithoutFeedback>
        <TouchableWithoutFeedback>
          <View style={styles.button}>
            <Text style={styles.text}>TouchableWithoutFeedback1</Text>
          </View>
        </TouchableWithoutFeedback>
        </ScrollView> */}
      </View>
    )
  }
}

const AppNavigator = createStackNavigator(
  {
    Home: {
      screen: HomeScreen,
    },
    Login: {
      screen: Login,
    },
  },
  {
    initialRouteName: 'Login',
  });

export default createAppContainer(AppNavigator);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'stretch',
    height: 200,
    width: '100%',
    padding: 40
  },
  input: {
    borderWidth: 1,
    borderColor: '#000',
    width: '100%',
    height: 45,
    borderRadius: 4,
    padding: 5,
    marginTop: 20
  },
  button: {
    marginTop: 30,
    // width: '100%',
    backgroundColor: 'skyblue',
    // alignItems: 'center',
    padding: 16,
    borderRadius: 4
  },
  text: {
    color: '#000',
    fontSize: 18
  }
})