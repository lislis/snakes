var Game_Over = {

  preload: function () {
    game.load.image('gameover', 'game-over.png');
  },
  create: function () {
    this.add.button(0, 0, 'gameover', this.startGame, this);
    game.add.text(200, 210, 'LAST SCORE', { font: "bold 20px sans-serif", fill: "#332F2C", align: "center" });
    game.add.text(350, 210, score.toString(), { font: "bold 20px sans-serif", fill: "#332F2C", align: "center" });
  },
  startGame: function () {
    this.state.start('Game');
  }

}
