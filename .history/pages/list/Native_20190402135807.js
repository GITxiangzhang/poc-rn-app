import React from 'react';
import { Platform, StyleSheet, Text, Image, View, TouchableOpacity, FlatList, Button, AlertIOS, NativeModules, DeviceEventEmitter } from 'react-native';
import listData from '../mockup/home'
import { createAppContainer, createDrawerNavigator, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
// const NativeDialog = NativeModules.JsAndroid

class List extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      data: []
    }

    this.onPress = this.onPress.bind(this)
    this.fetchData = this.fetchData.bind(this)
    this.updateEvents = this.updateEvents.bind(this)
  }

  componentDidMount() {
    this.fetchData()
    this.testDataListener = DeviceEventEmitter.addListener('pageData', e => {//for Android
      //更新状态及其他操作
      this.setState(prevState => ({
        data: [...prevState.data,
        {
          id: prevState.data.length + 1,
          value: e.data
        }
        ]
      }))
    });
  }

  componentWillUnmount() {
    this.testDataListener.remove()
  }

  updateEvents() {
    let data = ''
    if (Platform.OS === 'ios') {
      NativeModules.ReactNativeContainerVC.showWithCallback((data) => {
        if (!data) {
          return false
        }
        data = data
        console.log('data: ' + data)
      })
    } else {
      NativeModules.JsAndroid.showDialogFragment(msg => {
        // this.setState(prevState => ({
        //   data: [...prevState.data,
        //     {
        //       id: prevState.data.length + 1,
        //       value: msg
        //     }
        //   ]
        // }))
        data = msg
      }, err => {
        console.log(err);
      })

    }
    console.log('res  '+data)
    if (data) {
    this.setState(prevState => ({
      data: [...prevState.data,
        {
          id: prevState.data.length + 1,
          value: data
        }
      ]
    }))
  }
    // NativeModules.JsAndroid.finishRNActivity();
  }

  fetchData() {
    let url = '../mockup/home.json'

    // fetch(url, {
    //   method: 'get'
    // })
    //   .then(res => res.json())
    //   .then(resData => {
    //     console.log(resData)
    //     this.setState({
    //       data: resData
    //     })
    //   })
    //   .catch(err => {
    //     console.log('err: '+ err)
    //   })
    this.setState({
      data: listData.list
    })
  }
  onPress() {
    this.updateEvents()
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.dialogContainer}>
          <View style={styles.dialog}>
            <TouchableOpacity
              style={styles.button}
              underlayColor="yellow"
              onPress={this.onPress}>
              <Text style={styles.text}>popup native dialog</Text>
            </TouchableOpacity>
          </View>
        </View>
        <View style={styles.flatlist}>
          <FlatList
            data={this.state.data}
            renderItem={({ item }) => <Text style={styles.item}>{item.value}</Text>}
          />
        </View>
      </View>
    );
  }
}

const HomeStack = createStackNavigator({ List }, {
  defaultNavigationOptions: {
    title: 'React-native page',
    headerTitleStyle: {
      color: '#fff',
      alignSelf: 'center',
      textAlign: 'center',
      flexGrow: 1
    },
    headerStyle: {
      backgroundColor: '#037aff',
      color: '#fff'
    },
    headerLeft: <Button style={{ borderWidth: 0 }} title="Back" onPress={backPress}></Button>

  }
});
function backPress() {
  NativeModules.JsAndroid.finishRNActivity()
}

export default createAppContainer(HomeStack);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#2656fe',
    paddingLeft: 10,
    paddingRight: 10,
  },
  dialogContainer: {
    // backgroundColor: 'skyblue',
    marginBottom: 10,
    // marginTop: 60
  },
  dialog: {
    // flex: 1,
    marginBottom: 6,
    padding: 60,
    backgroundColor: '#eaf3ff',
    borderRadius: 8
  },
  button: {
    backgroundColor: 'blue',
    height: 40,
    // borderWidth: 1,
    borderColor: 'red',
    borderRadius: 8,
    borderColor: '#000',
    width: '100%',
    justifyContent: 'center',
    alignItems: 'center'
  },
  text: {
    textAlign: 'center',
    // flex: 1,
    color: '#fff',
    fontSize: 16
  },
  flatlist: {
    backgroundColor: '#f6f7fe',
    borderRadius: 8,
    overflow: 'hidden'
  },
  item: {
    // borderColor: '#000',
    // borderWidth: 1,
    padding: 15,
    flex: 1,
    backgroundColor: '#fff',
    marginBottom: 2
  }
})