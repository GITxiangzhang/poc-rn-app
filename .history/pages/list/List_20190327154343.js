import React from 'react';
import { StyleSheet, Text, View, ScrollView, TouchableOpacity, FlatList, Image } from 'react-native';
import { createAppContainer, createDrawerNavigator, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
import MyNative from './Native'
import Mapping from './Map'
import CameraScreen from './Camera'
// import { Initializer } from 'react-native-baidumap-sdk'

class List extends React.Component {
  constructor (props) {
    super(props)

    this._onPress = this._onPress.bind(this)
  }

  componentDidMount () {
    // Initializer.init('OGLCu52Y34t36RdzEzsm8yzwbRL0F09H').catch(e => console.error('init', e))
  }

  _onPress (id) {
    this.props.navigation.navigate(id)
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.header}>
          <View style={styles.headerContent}>
            <Text style={{textAlign: 'center', marginTop: 10}}>IN THIS TOPIC</Text>
            <Text style={{textAlign: 'center'}}>Dive into the world of coding and master principles by writing real code in JavaScript, a opular language.</Text>
          </View>
          <ScrollView>
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
          </ScrollView>
        </View>
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
    backgroundColor: '#2656fe'
  },
  header: {
    marginTop: 100, 
    flex: 1, 
    backgroundColor: '#f6f7fe',
  },
  headerContent: {
    backgroundColor: '#beffe7', 
    margin: 10,
    marginTop: -70, 
    borderRadius: 4, 
    padding: 20,
  },
  listContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 5,
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
    // backgroundColor: '#bfe2ef',
    margin: 20,
  },
  title: {
    color: '#2656fe',
    fontWeight: 'bold'
  },
  content: {
    color: '#2656fe'
  },
  button: {
    // marginTop: 30,
    // width: '100%',
    // backgroundColor: '#2656fe',
    // alignItems: 'center',
    // padding: 16,
    margin: 10,
    marginTop: 0,
    marginBottom: 4,
    borderRadius: 4,
    height: 80,
    // flex:1,
    borderRadius: 4,
  }
})