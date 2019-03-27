/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

<<<<<<< HEAD
import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View} from 'react-native';
import Login from './pages/Login'
import Home from './pages/Home'
=======
import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View, ToastAndroid, DeviceEventEmitter, NativeModules, TouchableOpacity } from 'react-native';
>>>>>>> b409e1a1cbbc7c87ee69c234d05404d00dce7e3c

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

<<<<<<< HEAD
// type Props = {};
export default class App extends Component {
  render() {
    // return (
    //   <View style={styles.container}>
    //     <Text style={styles.welcome}>Welcome to React Native!</Text>
    //     <Text style={styles.instructions}>To get started, edit App.js</Text>
    //     <Text style={styles.instructions}>{instructions}</Text>
    //   </View>
    // );
    return <Home/>
=======
type Props = {};
export default class App extends Component<Props> {

  constructor(props) {
    super(props);
    this.state = {
      greetings: '这是页面1'
    }
  }
  clickFun() {
    NativeModules.JsAndroid.showDialogFragment(msg => { console.log(msg); }, err => { console.log(err); })
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
    return (



      <View style={styles.container}>
        <TouchableOpacity onPress={this.clickFun}>
          <Text style={styles.welcome}>{this.state.greetings}</Text>
        </TouchableOpacity>

      </View>
    );
>>>>>>> b409e1a1cbbc7c87ee69c234d05404d00dce7e3c
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#eee',
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
