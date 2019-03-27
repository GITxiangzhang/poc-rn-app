
/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, Dimensions, Button} from 'react-native';
import { MapView, MapTypes, Geolocation, Overlay } from 'react-native-baidu-map';
const {height, width} = Dimensions.get('window');
console.log('map', height, width, Geolocation)


export default class App extends Component {
  constructor (props) {
    super(props)
    this.state = {
    }
  }

  render() {
    // const { infoWindowProps } = this.state;
    // console.warn('Overlay', Overlay)
    return (
      <View style={styles.container}>
        {/* // <Text>aaa</Text> */}
        {/* // <MapView ></MapView> */}
        <MapView 
          width={width} 
          height={400} 
          zoom={18}
          trafficEnabled={true}
          zoomControlsVisible={true}
          mapType={MapTypes.SATELLITE}
          center={{ longitude: 113.960453, latitude: 22.546045 }}
        >
        </MapView>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  }
});