package com.manchott.TTT.domain.game;

import com.manchott.TTT.domain.game.entity.Game;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class GameServiceTest {

    @Autowired
    private GameService gameService;

    @Test
    public void saveGame(SaveGameDto saveGameDto){
        Game game = gameService.saveGame(saveGameDto);
        assertEquals(1, game.getGameId());
    }

}