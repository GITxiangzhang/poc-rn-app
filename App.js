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

type Props = {};
export default class App extends Component<Props> {

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
