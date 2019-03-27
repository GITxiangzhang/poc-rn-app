
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
const {height, width} = Dimensions.get('window')
const { Marker, Arc, Circle, Polyline, Polygon, InfoWindow } = Overlay

export default class App extends Component {
  constructor (props) {
    super(props)
    this.state = {
      location: null,
      marker: {
        title: '当前位置',
        latitude: 32.0340503,
        longitude: 118.71761239999998
      }
    }
  }
  async componentDidMount () {
    await navigator.geolocation.getCurrentPosition((p) => {
      console.log(p.coords)
      this.setState({
        location: {
          latitude: p.coords.latitude,
          longitude: p.coords.longitude
        },
        marker: {
          title: '当前位置',
          latitude: 32.0340503,
          longitude: 118.71761239999998
        }
      })
    })
    await Geolocation.getCurrentPosition().then(res => console.log('mmm',res, res.latitude))
    // Geolocation.getCurrentPosition().then(position => {
    //   console.log(position)
    //   this.setState({
    //     location: position
    //   })
    // })
  }
  render() {
    // const { infoWindowProps } = this.state;
    // console.warn('Overlay', Overlay)
    return (
      <View style={styles.container}>
        <MapView
          width={width} 
          height={height} 
          zoom={18}
          trafficEnabled={true}
          zoomControlsVisible={true}
          mapType={MapTypes.NORMAL}
          center={{ longitude: 118.71761239999998, latitude: 32.0340503 }}
          markers={[this.state.marker]}
          // center={this.state.location}
          onMapLoaded={(e) => {
            Geolocation.getCurrentPosition().then(res => console.log('mmm',res, res.latitude)).catch(e => {
              console.log('e', e)
            })
          }}
        >
        {/* <Marker/> */}
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