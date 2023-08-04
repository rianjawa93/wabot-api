//const { Client } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const fs = require('fs');
const { Client, LocalAuth } = require('whatsapp-web.js');

const client = new Client({
    authStrategy: new LocalAuth()
});

//const client = new Client();
client.on('qr', (qr) => {
	qrcode.generate(qr,{small: true});
    // Generate and scan this code with your phone
    console.log('QR RECEIVED', qr);
});

client.on('ready', () => {
    console.log('Client is ready!');
});

//auto replay
// client.on('message', msg => {
//     if (msg.body == '!ping') {
//         msg.reply('pong');
//     } else if (msg.body == 'info') {
//         msg.reply('Cek GAN...!!');
//     } else {
//     	msg.reply('Maaf saat ini system dalam masa maintenance, silahkan hubungi kontak saya yang lain .. copyright@project 1.0 rianjawa93@gmail.com');
//     }
// });

//dynamic bot auto replay
const db =require('./helpers/db')
client.on(['message'], async msg => {
    console.log(msg);    
    const from = msg.from;
    const keyword = msg.body;
    const replyMessage = await db.getReply(keyword);
    //console.log(replyMessage);

    //info tentang saya / profil
    const key_saya = msg.from;
    const replyMy = await db.getMy(from);
    const replyMypwd = await db.getMypwd(from);
    //console.log(keyword);
    //console.log(key_saya);
    
    //info pesan yang dapat di balas wa-bot
    const replyInfo = await db.getInfo();

    //info pesan Pilih
    const replyPilih = await db.getPilih();

    if (replyMessage !== false) {
        msg.reply(replyMessage);
        //console.log(keyword);
        //console.log(from);
    } else if (msg.body == 'pilih') {
        msg.reply(replyPilih);
    } else if (msg.body == 'saya') {
        msg.reply(replyMy);
    } else if (msg.body == 'pwd') {
        msg.reply(replyMypwd);
    } else if (msg.body == 'info') {
        msg.reply(
            'TEIMAKASIH..'
            +'\n'+
            'Atau Dapat memilih salah satu *Opsi* berikut:'
            +'\n'+replyInfo
            +'\n'+
            ' .. copyright@project 1.0 rianjawa93@gmail.com ..');
    } else {
        msg.reply(msg.from+' Maaf saat ini system dalam masa *PENGEMBANGAN*, dan tidak menerima pesan'
            +'\n'+
            '==>( *_'+msg.body+'_* )<=='
            +'\n'+
            'silahkan hubungi kontak Admin'
            +'\n'+
            'Atau Dapat memilih salah satu *Opsi* berikut:'
            +'\n'+replyInfo
            +'\n'+
            ' .. copyright@project 1.0 rianjawa93@gmail.com ..');
    }
});

client.initialize();