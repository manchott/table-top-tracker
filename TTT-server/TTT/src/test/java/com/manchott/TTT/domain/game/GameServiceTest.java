package com.manchott.TTT.domain.game;

import com.manchott.TTT.TttApplication;
import com.manchott.TTT.domain.game.dto.SaveGameDto;
import com.manchott.TTT.domain.game.entity.Game;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.orm.jpa.JpaSystemException;
import org.springframework.test.context.ActiveProfiles;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = TttApplication.class)
@ActiveProfiles("develop")
class GameServiceTest {

    @Autowired
    private GameService gameService;

    @Test
    public void saveGame(){
        SaveGameDto saveGameDto = SaveGameDto.builder()
                .gameId(1L)
                .thumbnail("thumbnail")
                .nameEN("nameEN")
                .nameKR("nameKR")
                .weight("3.5")
                .description("description for test game")
                .yearPublished("2023")
                .minPlayers("4")
                .maxPlayers("5")
                .playingTime("30")
                .minPlayTime("15")
                .maxPlayTime("45")
                .build();
        Game game = gameService.saveGame(saveGameDto);
        assertEquals(1, game.getGameId());
    }

}