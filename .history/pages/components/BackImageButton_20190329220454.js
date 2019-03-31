import React, {Component} from 'react-native'

class BackImageButton extends Component {

  render () {
    return (
      <TouchableOpacity onPress={this.backPage}>
      <View style={{width: 100, flexDirection: 'row', justifyContent: 'center', alignItems: 'flex-start'}}>
        <Image style={{backgroundColor: 'red', color: '#fff'}} source={require('../assets/img/back-icon.png')}/>
        <Text style={{width:50, marginLeft: 10}}>back</Text>
      </View>
      </TouchableOpacity>
    )
  }
}

export default BackImageButton