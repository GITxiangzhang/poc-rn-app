/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import Home from './pages/list/Native'
import { Platform, StyleSheet, Button, Image, Text, View, ToastAndroid, DeviceEventEmitter, NativeModules, TouchableOpacity } from 'react-native';
import { createAppContainer, createDrawerNavigator, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};
export default class App extends Component<Props> {

  constructor(props) {
    super(props);
    this.state = {
      greetings: '这是页面1'
    }
  }
  clickFun() {
    NativeModules.JsAndroid.finishRNActivity()
  }
  componentWillMount() {
    //注册接收器
    this.testDataListener = DeviceEventEmitter.addListener('pageData', e => {//for Android
      //更新状态及其他操作
      this.setState({
        greetings: '这是页面' + e.data,
      })
    });
  }
  render() {
    return <Home></Home>
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#2656fe',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
