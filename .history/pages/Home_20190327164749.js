// import React, {Component} from 'react'
// import {Platform, StyleSheet, Text, View, Button, TextInput, TouchableHighlight} from 'react-native'
import { createBottomTabNavigator, createAppContainer } from 'react-navigation'

import List from './list/List'
import Settings from './settings/Settings'

const TabNavigator = createBottomTabNavigator({
  List: { screen: List },
  Web: { screen: List},
  Settings: { screen: Settings },
})

export default createAppContainer(TabNavigator)
