var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/login', (req, res) =>{
  res.render('login',{title:'login'});
});

router.get('/register', (req, res) =>{
  res.render('register',{title:'register'});
});

router.get('/forgotpass', (req, res) =>{
  res.render('forgotpass',{title:'forgot password'});
});

router.get('/mainofuser', (req, res) =>{
  res.render('mainofuser',{title:'main of user'});
});

router.get('/question', (req, res) =>{
  res.render('question',{title:'question'});
});

router.get('/quesdetail', (req, res) =>{
  res.render('quesdetail',{title:'question detail'});
});

router.get('/waiting-player', (req, res) =>{
  res.render('waiting-player',{title:'waiting game'});
});

router.get('/start-game', (req, res) =>{
  res.render('start-game',{title:'start game'});
});

router.get('/end-game', (req, res) =>{
  res.render('end-game',{title:'end game'});
});

router.get('/listquestion', (req, res) =>{
  res.render('listquestion',{title:'question detail'});
});

router.get('/library', (req, res) =>{
  res.render('library',{title:'library'});
});

router.get('/library-detail', (req, res) =>{
  res.render('library-detail',{title:'library'});
});

router.get('/aboutus', (req, res) =>{
  res.render('aboutus',{title:'about us'});
});

router.get('/account', (req, res) =>{
  res.render('account',{title:'account'});
});




module.exports = router;
