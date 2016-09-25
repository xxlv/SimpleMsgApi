# Description:
#  Huomao TV
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   x

request=require 'request'

class Huomao

    constructor: (@user,@pass)->
        @cookie='COOKIE HERE ';
        @user=@user
        @pass=@pass

    initSession:(room_id)->
        # update cookie & access once page
        # init session here
        url="http://www.huomao.com/#{room_id}"
        @_request url,'GET',[],(err,body)->

            console.log err if err
            return


    sendMsgTo:(room_id,msg)->

        @initSession(room_id)

        data=msg
        cid=room_id
        msg_type="msg"
        msg_send_type="msg"
        t=Date.parse(new Date())
        callback="jQuery171024991638706994124_1474722341039"

        url="http://chat.huomao.com/chat/sendMsg?callback=#{callback}&data=#{data}&cid=#{cid}&msg_type=#{msg_type}&msg_send_type=#{msg_send_type}&_=#{t}"

        @_request url,'GET',[],(err,body)->

            body=body.substring callback.length+1,body.length-1
            body= JSON.parse body

            if body.status
                console.log " Huomao Tv >> #{body.data.msg_content.username} 发送 #{body.data.msg_content.content} 消息到房间 #{body.data.msg_content.zb_name}(#{body.data.msg_content.channel_id})  => #{body.message}"
            else
                console.log "#{body.message}"


    _request:(api,method,data,cb)->
        context=
            url:api
            method:method
            headers:
                "cookie":"#{@cookie}"

        request context,(err,response,body)->
            cb err,body


module.exports=Huomao
