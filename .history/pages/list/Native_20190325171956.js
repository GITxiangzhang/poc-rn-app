import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, FlatList, Button, AlertIOS } from 'react-native';
import { createAppContainer, createStackNavigator, StackActions, NavigationActions } from 'react-navigation'
import listData from '../mockup/home'

class List extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      data: []
    }

    this.onPress = this.onPress.bind(this)
    this.fetchData = this.fetchData.bind(this)
  }

  componentDidMount () {
    this.fetchData()
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
      console.log(listData.list)
      this.setState({
        data: listData.list
      })
  }

  onPress () {
    AlertIOS.prompt(
      'Enter a value',
      null,
      text => {
        this.setState(prevState => ({
          data: [...prevState.data,
            {
              id: this.state.data.length + 1,
              value: text
            }
          ]
        }))
      }
    )
  }

  render() {
    return (
      <View>
        <Button onPress={this.onPress} title="alert native model"></Button>
        <FlatList
          data={this.state.data}
          renderItem = {({item}) => <Text>{item.value}</Text>}
        />
      </View>
    );
  }
}

export default List

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