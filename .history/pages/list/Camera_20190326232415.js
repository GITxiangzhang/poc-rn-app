
import { RNCamera } from 'react-native-camera';
import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';

export default class Camera extends React.Component {
  constructor (props) {
    super(props)

    this.setState({
      isRecording:false
    })
  }
  render() {
    return (
      <View style={styles.container}>
        <RNCamera
          ref={ref => {
            this.camera = ref;
          }}
          style={styles.preview}
          type={RNCamera.Constants.Type.back}
          flashMode={RNCamera.Constants.FlashMode.on}
          permissionDialogTitle={'Permission to use camera'}
          permissionDialogMessage={'We need your permission to use your camera phone'}
          onGoogleVisionBarcodesDetected={({ barcodes }) => {
            console.log(barcodes);
          }}
        />
          {/* {({ camera, status }) => {
            console.log(status);
            return (
              <View style={{ flex: 0, flexDirection: 'row', justifyContent: 'center' }}>
                  <TouchableOpacity onPress={() => this.zoomSize1v1(camera)} style={styles.capture}>
                    <Text style={{ fontSize: 14 }}> 1:1 </Text>
                  </TouchableOpacity>
                  <TouchableOpacity onPress={() => this.zoomSize16v9(camera)} style={styles.capture}>
                    <Text style={{ fontSize: 14 }}> 16:9 </Text>
                  </TouchableOpacity>

                  <TouchableOpacity onPress={() => this.takePicture(camera)} style={styles.capture}>
                    <Text style={{ fontSize: 14 }}> 拍照 </Text>
                  </TouchableOpacity>
                  {this.recordBtn(camera)}
              </View>
            );
          }} */}
          
        <View style={{ flex: 0, flexDirection: 'row', justifyContent: 'center' }}>
          <TouchableOpacity onPress={this.takePicture.bind(this)} style={styles.capture}>
            <Text style={{ fontSize: 14 }}> 1:1 </Text>
          </TouchableOpacity>
          <TouchableOpacity onPress={this.takePicture.bind(this)} style={styles.capture}>
            <Text style={{ fontSize: 14 }}> 16:9 </Text>
          </TouchableOpacity>

          <TouchableOpacity onPress={this.takePicture.bind(this)} style={styles.capture}>
            <Text style={{ fontSize: 14 }}> 拍照 </Text>
          </TouchableOpacity>

          {this.recordBtn()}
        </View>
        {/* </RNCamera> */}
      </View>
    );
  }
 
  recordBtn () {
    if (this.camera && this.state.isRecording) {
      <TouchableOpacity onPress={this.stopRecord.bind(this)} style={styles.capture}>
        <Text style={{ fontSize: 14 }}> 停止 </Text>
      </TouchableOpacity>
    } else {
      <TouchableOpacity onPress={this.takeRecord.bind(this)} style={styles.capture}>
        <Text style={{ fontSize: 14 }}> 摄像 </Text>
      </TouchableOpacity>
    }
  }

  zoomSize1v1 = async function (camera) {

  }

  zoomSize16v9 = async function (camera) {

  }
  
  takePicture = async function() {
    if (this.camera) {
      const options = { quality: 0.5, base64: true};
      const data = await this.camera.takePictureAsync(options);
      console.log(data.uri);
    }
  };

  //开始录像
  takeRecord= async function(camera){
    this.setState({isRecording:true});
    const options = { quality:RNCamera.Constants.VideoQuality["480p"],maxFileSize:(100*1024*1024) };
    const data = await camera.recordAsync(options);
    console.log(data);
    this.props.navigation.navigate('parentPage',{videoUrl:data.uri})
  };
  //停止录像
  stopRecord(camera){
      this.setState({isRecording:false});
      camera.stopRecording()
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    backgroundColor: '#fff',
  },
  preview: {
    flex: 1,
    justifyContent: 'flex-end',
    alignItems: 'center',
  },
  capture: {
    flex: 0,
    borderWidth: 1,
    backgroundColor: '#fff',
    borderRadius: 5,
    padding: 15,
    paddingHorizontal: 20,
    alignSelf: 'center',
    margin: 20,
  },
});
