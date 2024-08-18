//post EdnPoint
//https://push-api.cloud.huawei.com/v1/110585617/messages:send  //number is client_id
//header
//Content-Type : application/json
//Authorization : Bearer DAEBABJZM+uGFO+LOWWATa54JRtBpYgqS7u2roVCsCF5j+87NBfjwBvxIZSfubL1PYPdySyN0JiM4GN9tU8aveXiy57dwYJC9V439Q==

//Body
// {
// "validate_only": false,
// "message": {
// "data": "{\"id\":\"1\",\"title\":\"This is Big News\",\"view\":\"view\",\"sectionid\":\"5\"}",
// "notification": {
// "title": "Big News",
// "body": "This is a Big News!"
// },
// "android": {
// "collapse_key": -1,
// "urgency": "NORMAL",
// "category": "PLAY_VOICE",
// "ttl": "1448s",
// "bi_tag": "Trump",
// "fast_app_target": 1,
// "notification": {
// "default_sound": true,
// "importance": "NORMAL",
// "click_action": {
// "type": 3,
// "intent": "intent://com.huawei.codelabpush/deeplink?#Intent;scheme=pushscheme;launchFlags=0x04000000;i.age=180;S.name=abc;end",
// "url": "https://www.vmall.com"
// },
// "channel_id": "HMSTestDemo",
// "style": 0,
// "big_title": "Big News",
// "big_body": "This is a Big News!",
// "notify_id": 486,
// "group": "Espace",
// "badge": {
// "add_num": 1,
// "class": "com.huawei.demo.push.HuaweiPushApiExample"
// },
// "foreground_show": true,
// "ticker": "I am a ticker",
// "use_default_vibrate": true,
// "use_default_light": true,
// "visibility": "PUBLIC",
// "vibrate_config": [
// "1",
// "3"
// ],
// "light_settings": {
// "color": {
// "alpha": 0,
// "red": 0,
// "green": 1,
// "blue": 0.1
// },
// "light_on_duration": "3.5",
// "light_off_duration": "5S"
// }
// }
// },
// "token": [ //this token for huawei device
// "eiYzHU5NSWK78H2LejDSFq:APA91bG6KjkefxWMtuoYBZogVgHrYA-i6NLNTvtyCJ8kbcEAZbPGZamUc-ieP06_pR4A3izTTSSZTYT5z817qVQdb_8oL94tkKR2kc1X00ZQcCaCiNOIm3bRvgiAxWMdyuWROo-Ar4OK"
// ]
// }
// }