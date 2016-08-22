var snake, apple, squareSize, score, speed,
  updateDelay, direction, newDirection,
  addNew, cursors, scoreTextValue, speedTextValue,
  textStyleKey, textStyleValue;

var Game = {

  preload: function () {
    game.load.image('snake', 'snake.png');
    game.load.image('apple', 'apple.png');
  },

  create: function () {

    snake = [];
    apple = {};
    squareSize = 15;
    score = 0;
    speed = 0;
    updateDelay = 0;
    direction = 'right';
    newDirection = null;
    addNew = false;

    cursors = game.input.keyboard.createCursorKeys();

    game.stage.backgroundColor = '#F7DA4B';

    var graphics = game.add.graphics(0, 0);

    for ( var i = 0; i < 5; i++ ) {
      snake[i] = game.add.sprite(150 + i * squareSize, 150, 'snake');

    }

    this.generateApple();

    textStyleKey = { font: 'bold 14px sans-serif', fill: '#332F2C', align: 'center'};
    textStyleValue = { font: 'bold 18px sans-serif', fill: '#332F2C', align: 'center' };

    game.add.text(30, 20, 'SCORE', textStyleKey);
    scoreTextValue = game.add.text(90, 18, score.toString(), textStyleValue);

    game.add.text(500, 20, 'SPEED', textStyleKey);
    speedTextValue = game.add.text(558, 18, speed.toString(), textStyleValue);
    

  },
  update: function () {

    if (cursors.right.isDown && direction != 'left') {
      newDirection = 'right'; 
    } else if (cursors.left.isDown && direction != 'right' ) {
      newDirection = 'left';
    } else if (cursors.up.isDown && direction != 'down') {
      newDirection = 'up';
    } else if (cursors.down.isDown && direction != 'up') {
      newDirection = 'down';
    }

    speed = Math.min(10, Math.floor(score/5));
    speedTextValue.text = ' ' + speed;

    updateDelay++;

    if (updateDelay % (10 - speed) === 0) {

      var firstCell = snake[snake.length - 1];
      var lastCell = snake.shift();
      var oldLastCellX = lastCell.x;
      var oldLastCellY = lastCell.y;

      if (newDirection) {
        direction = newDirection;
        newDirection = null;
      }

      if (direction === 'right') {
        lastCell.x = firstCell.x + 15;
        lastCell.y = firstCell.y;
      } else if (direction === 'left') {
        lastCell.x = firstCell.x - 15;
        lastCell.y = firstCell.y;
      } else if (direction === 'up') {
        lastCell.x = firstCell.x;
        lastCell.y = firstCell.y - 15;
      } else if (direction === 'down') {
        lastCell.x = firstCell.x;
        lastCell.y = firstCell.y + 15;
      }

      snake.push(lastCell);
      firstCell = lastCell;

      if (addNew) {
        snake.unshift(game.add.sprite(oldLastCellX, oldLastCellY, 'snake'));
        addNew = false;
      }

      this.appleCollision();

      this.selfCollision(firstCell);

      this.wallCollision(firstCell);
    }
  },

  appleCollision: function () {
    for (var i = 0; i < snake.length; i++) {
      if (snake[i].x === apple.x && snake[i].y === apple.y) {

        addNew = true;
        apple.destroy();
        this.generateApple();
        score++;
        scoreTextValue.text = score.toString();
      }
    }
  },
  selfCollision: function (head) {
    for (var i = 0; i < snake.length - 1; i++) {
      if (head.x === snake[i].x && head.y === snake[i].y) {
        game.state.start('Game_Over');
      }
    }
  },
  wallCollision: function (head) {
    if (head.x >= 600 || head.x < 0 || head.y >= 450 || head.y < 0) {
      game.state.start('Game_Over');
    }
  },
  generateApple: function () {

    var randomX = Math.floor(Math.random() * 40) * squareSize;
    var randomY = Math.floor(Math.random() * 30) * squareSize;

    apple = game.add.sprite(randomX, randomX, 'apple');
  }

};
