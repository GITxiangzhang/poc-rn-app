import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, FlatList, Button, AlertIOS,  NativeModules, DeviceEventEmitter} from 'react-native';
import { createAppContainer, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
import listData from '../mockup/home'
const NativeDialog = NativeModules.JsAndroid

class List extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      data: []
    }

    this.onPress = this.onPress.bind(this)
    this.fetchData = this.fetchData.bind(this)
    this.updateEvents = this.updateEvents.bind(this)
  }

  componentDidMount () {
    this.fetchData()
    this.testDataListener = DeviceEventEmitter.addListener('pageData', e => {//for Android
      //更新状态及其他操作
      this.setState(prevState => ({
        data: [...prevState.data,
          {
            id: this.state.data.length + 1,
            value: e.data
          }
        ]
      }))
    });
  }

  async updateEvents() {
    // try {
    await NativeDialog.showDialogFragment();
  
      // this.setState({data: events});
    // } catch (e) {
      // console.error(e);
    // }
  }

  fetchData () {
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

  onPress () {
    this.updateEvents()
    // AlertIOS.prompt(
    //   'add a value to list',
    //   null,
    //   text => {
    //     this.setState(prevState => ({
    //       data: [...prevState.data,
    //         {
    //           id: this.state.data.length + 1,
    //           value: text
    //         }
    //       ]
    //     }))
    //   }
    // )
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.dialogContainer}>
          <View style={styles.dialog}>
            <Button style={styles.button} onPress={this.onPress} title="alert native model && add to list"></Button>
          </View>
        </View>
        <View style={styles.flatlist}>
          <FlatList
            data={this.state.data}
            renderItem = {({item}) => <Text style={styles.item}>{item.value}</Text>}
          />
        </View>
      </View>
    );
  }
}

export default List

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#2656fe',
    paddingLeft: 10,
    paddingRight: 10
  },
  dialogContainer: {
    // backgroundColor: 'skyblue',
    marginBottom: 10,
  },
  dialog: {
    // flex: 1,
    marginBottom: 6,
    padding: 40,
    backgroundColor: '#fff',
    borderRadius: 8

  },
  button: {
    backgroundColor: '#f6f7fe',
    height: 80,
    borderRadius: 4,
    borderColor: '#000'
  },
  flatlist: {
    backgroundColor: '#f6f7fe',
    borderRadius: 8
  },
  item: {
    // borderColor: '#000',
    // borderWidth: 1,
    padding: 10,
    flex: 1,
    backgroundColor: '#fff',
    marginBottom: 2
  }
})