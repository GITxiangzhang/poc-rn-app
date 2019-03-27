import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, FlatList, Image } from 'react-native';
import { createAppContainer, createDrawerNavigator, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
import MyNative from './Native'
import Mapping from './Map'
import CameraScreen from './Camera'
import { Initializer } from 'react-native-baidumap-sdk'

class List extends React.Component {
  constructor (props) {
    super(props)

    this._onPress = this._onPress.bind(this)
  }

  componentDidMount () {
    Initializer.init('OGLCu52Y34t36RdzEzsm8yzwbRL0F09H').catch(e => console.error('init', e))
  }

  _onPress (id) {
    this.props.navigation.navigate(id)
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity
         style={styles.button}
         underlayColor="yellow"
         onPress={() => this._onPress('WebNative')}>
          <View style={styles.listContainer}>
            <Image source={require('../assets/img/icon_add.png')} style={styles.thumbnail}/>
            <View style={styles.textContainer}>
              <Text style={styles.title}>go  web view</Text>
              <Text style={styles.content}>from native to proto</Text>
            </View>
          </View>
        </TouchableOpacity>
        <TouchableOpacity
         style={styles.button}
         underlayColor="yellow"
         onPress={() => this._onPress('Mapping')}>
          <View style={styles.listContainer}>
            <Image source={require('../assets/img/icon_GPS.png')} style={styles.thumbnail}/>
            <View style={styles.textContainer}>
              <Text style={styles.title}>map</Text>
              <Text style={styles.content}>get targeting</Text>
            </View>
          </View>
        </TouchableOpacity>
        <TouchableOpacity
         style={styles.button}
         underlayColor="yellow"
         onPress={() => this._onPress('Camera')}>
          <View style={styles.listContainer}>
            <Image source={require('../assets/img/icon_camera.png')} style={styles.thumbnail}/>
            <View style={styles.textContainer}>
              <Text style={styles.title}>camera</Text>
              <Text style={styles.content}>wake up the camera</Text>
            </View>
          </View>
        </TouchableOpacity>
      </View>
    );
  }
}

const MyStackerNavigator = createStackNavigator({
  WebNative: {
    screen: MyNative,
  },
  Mapping: {
    screen: Mapping
  },
  Camera: {
    screen: CameraScreen
  },
  MainHome: {
    screen: List,
  },

},{
  initialRouteName: 'MainHome'
});

const MyApp = createAppContainer(MyStackerNavigator);

export default MyApp

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ddd'
  },
  listContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 10,
    backgroundColor: '#fff',
    // height: 80,
    height: '100%',
    marginTop: 10
  },
  textContainer: {
    flex: 1,
  },
  thumbnail: {
    width: 30,
    height: 30,
    backgroundColor: '#bfe2ef',
    margin: 20
  },
  title: {
    color: 'steelblue',
    fontWeight: 'bold'
  },
  content: {
    color: 'powderblue'
  },
  button: {
    // marginTop: 30,
    // width: '100%',
    backgroundColor: 'skyblue',
    // alignItems: 'center',
    // padding: 16,
    height: 80,
    // flex:1,
    borderRadius: 4
  }
})