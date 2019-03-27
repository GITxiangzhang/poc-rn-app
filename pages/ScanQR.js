import React from 'react';
import { Text, View , StyleSheet, Button, Image} from 'react-native';
import { createDrawerNavigator, createAppContainer } from 'react-navigation'
import List from './list/Native'
class MyHomeScreen extends React.Component {
  // static navigationOptions = {
  //   drawerLabel: 'Home1',
  //   drawerIcon: ({ tintColor }) => (
  //     <Image
  //       source={require('./assets/img/aa.png')}
  //       style={[styles.icon, {tintColor: tintColor}]}
  //     />
  //   ),
  // };
  componentDidMount () {
    // this.props.navigation.toggleDrawer();
  }

  render() {
    return (
      <Button
        onPress={() => this.props.navigation.navigate('Notifications')}
        title="Go to notifications"
      />
    );
  }
}

class MyNotificationsScreen extends React.Component {
  // static navigationOptions = {
  //   drawerLabel: 'Notifications',
  //   drawerIcon: ({ tintColor }) => (
  //     <Image
  //       source={require('./assets/img/aa.png')}
  //       style={[styles.icon, {tintColor: tintColor}]}
  //     />
  //   ),
  // };
  componentDidMount () {
    // this.props.navigation.toggleDrawer();
  }
  render() {
    return (
      <Button
        onPress={() => this.props.navigation.goBack()}
        title="Go back home"
      />
    );
  }
}

const styles = StyleSheet.create({
  icon: {
    width: 24,
    height: 24,
  },
});

const MyDrawerNavigator = createDrawerNavigator({
  Home: {
    screen: List,
  },
  Notifications: {
    screen: MyNotificationsScreen,
  },
},{
  initialRouteName: 'Home'
});

const MyApp = createAppContainer(MyDrawerNavigator);

export default MyApp