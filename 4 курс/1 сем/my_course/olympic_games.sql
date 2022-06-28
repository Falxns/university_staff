CREATE TABLE `cities` (
  `cityID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `countryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `countries` (
  `countryID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `olympicGames` (
  `olympicGameID` int(11) NOT NULL,
  `name` enum('winter','summer') NOT NULL,
  `cityID` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `sequnce` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `olympicGamesDiciplines` (
  `olympicGameID` int(11) NOT NULL,
  `diciplineID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `olympicGamesLogos` (
  `olympicGameID` int(11) NOT NULL,
  `nameLogo` varchar(50) NOT NULL,
  `imageLogo` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `olympicGamesParticipants` (
  `olympicGameID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `countryID` int(11) NOT NULL,
  `diciplineID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `olympicGamesSponsors` (
  `olympicGameID` int(11) NOT NULL,
  `sponsorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `olympicTalismanLogos` (
  `olympicTalismanID` int(11) NOT NULL,
  `image` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `olympicTalismans` (
  `olympicTalismanID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `olympicGameID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `otherDocument` (
  `documentID` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `priority` int(11) NOT NULL,
  `dbLoadingDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `otherDocumentContent` (
  `documentID` int(11) NOT NULL,
  `content` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `otherDocumentEvent` (
  `documentID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `personAwards` (
  `awardID` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `diciplineID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `personAwardsHistory` (
  `personID` int(11) NOT NULL,
  `awardID` int(11) NOT NULL,
  `date` date NOT NULL,
  `currency` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `personDiciplinesHistory` (
  `personID` int(11) NOT NULL,
  `diciplineID` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `persondisqhstr` (
  `personID` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `disqComment` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `personInfoHistory` (
  `personInfoID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `marriedStatus` char(2) NOT NULL,
  `disabilityStatus` char(2) NOT NULL,
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `personInjuries` (
  `injuryID` int(11) NOT NULL,
  `injuryType` varchar(50) NOT NULL,
  `injuryName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `personInjuriesHistory` (
  `injuryID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `dateStart` date NOT NULL,
  `duration` varchar(50) NOT NULL,
  `injuryComment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `persons` (
  `personID` int(11) NOT NULL,
  `firstName` int(11) NOT NULL,
  `lastName` int(11) NOT NULL,
  `middleName` int(11) DEFAULT NULL,
  `gender` enum('m','w') NOT NULL,
  `dateBirth` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sponsors` (
  `sponsorID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `tagline` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportapplications` (
  `applicationID` int(11) NOT NULL,
  `parent_appID` int(11) DEFAULT NULL,
  `eventID` int(11) NOT NULL,
  `personID` int(11) DEFAULT NULL,
  `countryID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportCompetitions` (
  `sportCompetitionID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sportDiciplineID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportDiciplines` (
  `sportDiciplineID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sportKindID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportEvents` (
  `sportEventID` int(11) NOT NULL,
  `competitionID` int(11) NOT NULL,
  `competitionPlaceID` int(11) NOT NULL,
  `stage` enum('qualification','final') NOT NULL,
  `date` date NOT NULL,
  `timeStart` time NOT NULL,
  `timeEnd` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportKinds` (
  `sportKindsID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportObjectAddresses` (
  `sportObjectID` int(11) NOT NULL,
  `cityID` int(11) NOT NULL,
  `streetName` varchar(50) NOT NULL,
  `streetType` int(50) NOT NULL,
  `buildingNumber` int(11) NOT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `longitute` int(11) NOT NULL,
  `latitude` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportObjectPlaces` (
  `sportObjectPlaceID` int(11) NOT NULL,
  `sportObjectID` int(11) NOT NULL,
  `placeType` varchar(50) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportObjects` (
  `sportObjectID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `sportObjectType` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL,
  `olympicGamesID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `sportResults` (
  `applicationID` int(11) NOT NULL,
  `result` varchar(50) NOT NULL,
  `place` int(11) NOT NULL,
  `isDisq` char(2) DEFAULT NULL,
  `isFail` char(2) DEFAULT NULL,
  `typeWin` enum('win','lose','draw','') DEFAULT NULL,
  `failComment` varchar(200) DEFAULT NULL,
  `medalType` enum('gold','silver','brons','') DEFAULT NULL,
  `isOlympicRecord` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tvChannels` (
  `tvChannelID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tvChannelsBroadcasts` (
  `tvChannelsBroadcastID` int(11) NOT NULL,
  `tvChannelID` int(11) NOT NULL,
  `eventID` int(11) NOT NULL,
  `date` int(11) NOT NULL,
  `timeStart` time NOT NULL,
  `timeEnd` time DEFAULT NULL,
  `isLive` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `uActions` (
  `actionID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `userID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `uLanguages` (
  `languageID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `uRoleActions` (
  `roleID` int(11) NOT NULL,
  `actionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `uRoles` (
  `roleID` int(11) NOT NULL,
  `name` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `userLanguage` (
  `userID` int(11) NOT NULL,
  `languageID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `userRoles` (
  `userID` int(11) NOT NULL,
  `roleID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `dateBirth` date NOT NULL,
  `dateRegistration` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `weatherConditions` (
  `eventID` int(11) NOT NULL,
  `temperature` int(11) NOT NULL,
  `snowLevel` int(11) DEFAULT NULL,
  `windSpeed` int(11) NOT NULL,
  `windDirection` enum('n','w','s','e','nw','ne','sw','se') NOT NULL,
  `waterLevel` int(11) DEFAULT NULL,
  `preassure` int(11) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`cityID`),
  ADD KEY `countryID` (`countryID`),
  ADD KEY `name` (`name`);

-- Индексы таблицы `countries`

ALTER TABLE `countries`
  ADD PRIMARY KEY (`countryID`),
  ADD KEY `name` (`name`);

-- Индексы таблицы `olympicGames`
--
ALTER TABLE `olympicGames`
  ADD PRIMARY KEY (`olympicGameID`),
  ADD UNIQUE KEY `sequnce` (`sequnce`),
  ADD KEY `cityID` (`cityID`);

-- Индексы таблицы `olympicGamesDiciplines`
--
ALTER TABLE `olympicGamesDiciplines`
  ADD PRIMARY KEY (`olympicGameID`,`diciplineID`),
  ADD KEY `diciplineID` (`diciplineID`);
--
-- Индексы таблицы `olympicGamesLogos`
--
ALTER TABLE `olympicGamesLogos`
  ADD PRIMARY KEY (`olympicGameID`);
--
-- Индексы таблицы `olympicGamesParticipants`
--
ALTER TABLE `olympicGamesParticipants`
  ADD PRIMARY KEY (`olympicGameID`,`personID`),
  ADD KEY `countryID` (`countryID`),
  ADD KEY `diciplineID` (`diciplineID`),
  ADD KEY `personID` (`personID`);

-- Индексы таблицы `olympicGamesSponsors`

ALTER TABLE `olympicGamesSponsors`
  ADD PRIMARY KEY (`olympicGameID`,`sponsorID`),
  ADD KEY `sponsorID` (`sponsorID`);

-- Индексы таблицы `olympicTalismanLogos`

ALTER TABLE `olympicTalismanLogos`
  ADD PRIMARY KEY (`olympicTalismanID`);

-- Индексы таблицы `olympicTalismans`
--
ALTER TABLE `olympicTalismans`
  ADD PRIMARY KEY (`olympicTalismanID`),
  ADD KEY `olympicGameID` (`olympicGameID`);

-- Индексы таблицы `otherDocument`
--
ALTER TABLE `otherDocument`
  ADD PRIMARY KEY (`documentID`);

-- Индексы таблицы `otherDocumentContent`
--
ALTER TABLE `otherDocumentContent`
  ADD PRIMARY KEY (`documentID`);

-- Индексы таблицы `otherDocumentEvent`
--
ALTER TABLE `otherDocumentEvent`
  ADD PRIMARY KEY (`documentID`,`eventID`),
  ADD KEY `eventID` (`eventID`);

-- Индексы таблицы `personAwards`
--
ALTER TABLE `personAwards`
  ADD PRIMARY KEY (`awardID`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `diciplineID` (`diciplineID`);

-- Индексы таблицы `personAwardsHistory`
--
ALTER TABLE `personAwardsHistory`
  ADD PRIMARY KEY (`awardID`,`date`) USING BTREE,
  ADD KEY `personID` (`personID`);

-- Индексы таблицы `personDiciplinesHistory`
--
ALTER TABLE `personDiciplinesHistory`
  ADD PRIMARY KEY (`personID`,`diciplineID`,`startDate`),
  ADD KEY `diciplineID` (`diciplineID`);

-- Индексы таблицы `persondisqhstr`
--
ALTER TABLE `persondisqhstr`
  ADD PRIMARY KEY (`personID`,`startDate`);

-- Индексы таблицы `personInfoHistory`
--
ALTER TABLE `personInfoHistory`
  ADD PRIMARY KEY (`personInfoID`),
  ADD KEY `personID` (`personID`);

-- Индексы таблицы `personInjuries`
--
ALTER TABLE `personInjuries`
  ADD PRIMARY KEY (`injuryID`);

-- Индексы таблицы `personInjuriesHistory`
--
ALTER TABLE `personInjuriesHistory`
  ADD PRIMARY KEY (`injuryID`,`personID`,`dateStart`),
  ADD KEY `personID` (`personID`);

-- Индексы таблицы `persons`
--
ALTER TABLE `persons`
  ADD PRIMARY KEY (`personID`),
  ADD KEY `firstName` (`firstName`);

-- Индексы таблицы `sponsors`
--
ALTER TABLE `sponsors`
  ADD PRIMARY KEY (`sponsorID`);

-- Индексы таблицы `sportapplications`
--
ALTER TABLE `sportapplications`
  ADD PRIMARY KEY (`applicationID`),
  ADD KEY `eventID` (`eventID`),
  ADD KEY `parent_appID` (`parent_appID`),
  ADD KEY `personID` (`personID`),
  ADD KEY `countryID` (`countryID`);

-- Индексы таблицы `sportCompetitions`
--
ALTER TABLE `sportCompetitions`
  ADD PRIMARY KEY (`sportCompetitionID`),
  ADD KEY `sportDiciplineID` (`sportDiciplineID`),
  ADD KEY `name` (`name`);

-- Индексы таблицы `sportDiciplines`
--
ALTER TABLE `sportDiciplines`
  ADD PRIMARY KEY (`sportDiciplineID`),
  ADD KEY `sportKindID` (`sportKindID`),
  ADD KEY `name` (`name`);

-- Индексы таблицы `sportEvents`
--
ALTER TABLE `sportEvents`
  ADD PRIMARY KEY (`sportEventID`),
  ADD KEY `competitionID` (`competitionID`),
  ADD KEY `competitionPlaceID` (`competitionPlaceID`),
  ADD KEY `stage` (`stage`),
  ADD KEY `date` (`date`);

-- Индексы таблицы `sportKinds`
--
ALTER TABLE `sportKinds`
  ADD PRIMARY KEY (`sportKindsID`),
  ADD KEY `name` (`name`);

-- Индексы таблицы `sportObjectAddresses`
--
ALTER TABLE `sportObjectAddresses`
  ADD PRIMARY KEY (`sportObjectID`),
  ADD KEY `cityID` (`cityID`);

-- Индексы таблицы `sportObjectPlaces`
--
ALTER TABLE `sportObjectPlaces`
  ADD PRIMARY KEY (`sportObjectPlaceID`),
  ADD KEY `sportObjectID` (`sportObjectID`);

-- Индексы таблицы `sportObjects`
--
ALTER TABLE `sportObjects`
  ADD PRIMARY KEY (`sportObjectID`),
  ADD KEY `name` (`name`),
  ADD KEY `olympicGamesID` (`olympicGamesID`);

-- Индексы таблицы `sportResults`
--
ALTER TABLE `sportResults`
  ADD PRIMARY KEY (`applicationID`);

-- Индексы таблицы `tvChannels`
--
ALTER TABLE `tvChannels`
  ADD PRIMARY KEY (`tvChannelID`),
  ADD KEY `name` (`name`);

-- Индексы таблицы `tvChannelsBroadcasts`
--
ALTER TABLE `tvChannelsBroadcasts`
  ADD PRIMARY KEY (`tvChannelsBroadcastID`),
  ADD KEY `tvChannelID` (`tvChannelID`),
  ADD KEY `eventID` (`eventID`);

-- Индексы таблицы `uActions`
--
ALTER TABLE `uActions`
  ADD PRIMARY KEY (`actionID`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `userID` (`userID`);

-- Индексы таблицы `uLanguages`
--
ALTER TABLE `uLanguages`
  ADD PRIMARY KEY (`languageID`),
  ADD UNIQUE KEY `name` (`name`);

-- Индексы таблицы `uRoleActions`
--
ALTER TABLE `uRoleActions`
  ADD PRIMARY KEY (`roleID`,`actionID`),
  ADD KEY `actionID` (`actionID`);

-- Индексы таблицы `uRoles`
--
ALTER TABLE `uRoles`
  ADD PRIMARY KEY (`roleID`),
  ADD UNIQUE KEY `name` (`name`);
-- Индексы таблицы `userLanguage`
--
ALTER TABLE `userLanguage`
  ADD PRIMARY KEY (`userID`,`languageID`),
  ADD KEY `languageID` (`languageID`);

-- Индексы таблицы `userRoles`
--
ALTER TABLE `userRoles`
  ADD PRIMARY KEY (`userID`,`roleID`),
  ADD KEY `roleID` (`roleID`);

-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `login` (`login`);

-- Индексы таблицы `weatherConditions`
--
ALTER TABLE `weatherConditions`
  ADD PRIMARY KEY (`eventID`);

-- AUTO_INCREMENT для сохранённых таблиц
-- AUTO_INCREMENT для таблицы `cities`
--
ALTER TABLE `cities`
  MODIFY `cityID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `countries`
--
ALTER TABLE `countries`
  MODIFY `countryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `olympicGames`
--
ALTER TABLE `olympicGames`
  MODIFY `olympicGameID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `olympicGamesLogos`
--
ALTER TABLE `olympicGamesLogos`
  MODIFY `olympicGameID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `olympicTalismans`
--
ALTER TABLE `olympicTalismans`
  MODIFY `olympicTalismanID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `otherDocument`
--
ALTER TABLE `otherDocument`
  MODIFY `documentID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `personAwards`
--
ALTER TABLE `personAwards`
  MODIFY `awardID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `personInfoHistory`
--
ALTER TABLE `personInfoHistory`
  MODIFY `personInfoID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `personInjuries`
--
ALTER TABLE `personInjuries`
  MODIFY `injuryID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `persons`
--
ALTER TABLE `persons`
  MODIFY `personID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sponsors`
--
ALTER TABLE `sponsors`
  MODIFY `sponsorID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `sportapplications`
--
ALTER TABLE `sportapplications`
  MODIFY `applicationID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sportCompetitions`
--
ALTER TABLE `sportCompetitions`
  MODIFY `sportCompetitionID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sportDiciplines`
--
ALTER TABLE `sportDiciplines`
  MODIFY `sportDiciplineID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sportEvents`
--
ALTER TABLE `sportEvents`
  MODIFY `sportEventID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sportKinds`
--
ALTER TABLE `sportKinds`
  MODIFY `sportKindsID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sportObjectPlaces`
--
ALTER TABLE `sportObjectPlaces`
  MODIFY `sportObjectPlaceID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `sportObjects`
--
ALTER TABLE `sportObjects`
  MODIFY `sportObjectID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `tvChannels`
--
ALTER TABLE `tvChannels`
  MODIFY `tvChannelID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `tvChannelsBroadcasts`
--
ALTER TABLE `tvChannelsBroadcasts`
  MODIFY `tvChannelsBroadcastID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uActions`
--
ALTER TABLE `uActions`
  MODIFY `actionID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uLanguages`
--
ALTER TABLE `uLanguages`
  MODIFY `languageID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `uRoles`
--
ALTER TABLE `uRoles`
  MODIFY `roleID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT;
--
-- Ограничения внешнего ключа сохраненных таблиц

-- Ограничения внешнего ключа таблицы `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`countryID`) REFERENCES `countries` (`countryID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `olympicGames`
--
ALTER TABLE `olympicGames`
  ADD CONSTRAINT `olympicgames_ibfk_1` FOREIGN KEY (`cityID`) REFERENCES `cities` (`cityID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `olympicGamesDiciplines`
--
ALTER TABLE `olympicGamesDiciplines`
  ADD CONSTRAINT `olympicgamesdiciplines_ibfk_2` FOREIGN KEY (`diciplineID`) REFERENCES `sportDiciplines` (`sportDiciplineID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `olympicgamesdiciplines_ibfk_1` FOREIGN KEY (`olympicGameID`) REFERENCES `olympicGames` (`olympicGameID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `olympicGamesLogos`
--
ALTER TABLE `olympicGamesLogos`
  ADD CONSTRAINT `olympicgameslogos_ibfk_1` FOREIGN KEY (`olympicGameID`) REFERENCES `olympicGames` (`olympicGameID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `olympicGamesParticipants`
--
ALTER TABLE `olympicGamesParticipants`
  ADD CONSTRAINT `olympicgamesparticipants_ibfk_4` FOREIGN KEY (`diciplineID`) REFERENCES `sportDiciplines` (`sportDiciplineID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `olympicgamesparticipants_ibfk_1` FOREIGN KEY (`olympicGameID`) REFERENCES `olympicGames` (`olympicGameID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `olympicgamesparticipants_ibfk_2` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `olympicgamesparticipants_ibfk_3` FOREIGN KEY (`countryID`) REFERENCES `countries` (`countryID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `olympicGamesSponsors`
--
ALTER TABLE `olympicGamesSponsors`
  ADD CONSTRAINT `olympicgamessponsors_ibfk_2` FOREIGN KEY (`sponsorID`) REFERENCES `sponsors` (`sponsorID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `olympicgamessponsors_ibfk_1` FOREIGN KEY (`olympicGameID`) REFERENCES `olympicGames` (`olympicGameID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `olympicTalismans`
--
ALTER TABLE `olympicTalismans`
  ADD CONSTRAINT `olympictalismans_ibfk_2` FOREIGN KEY (`olympicTalismanID`) REFERENCES `olympicTalismanLogos` (`olympicTalismanID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `olympictalismans_ibfk_1` FOREIGN KEY (`olympicGameID`) REFERENCES `olympicGames` (`olympicGameID`);

-- Ограничения внешнего ключа таблицы `otherDocumentContent`
--
ALTER TABLE `otherDocumentContent`
  ADD CONSTRAINT `otherdocumentcontent_ibfk_1` FOREIGN KEY (`documentID`) REFERENCES `otherDocument` (`documentID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `otherDocumentEvent`
--
ALTER TABLE `otherDocumentEvent`
  ADD CONSTRAINT `otherdocumentevent_ibfk_2` FOREIGN KEY (`eventID`) REFERENCES `sportEvents` (`sportEventID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `otherdocumentevent_ibfk_1` FOREIGN KEY (`documentID`) REFERENCES `otherDocument` (`documentID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `personAwards`
--
ALTER TABLE `personAwards`
  ADD CONSTRAINT `personawards_ibfk_1` FOREIGN KEY (`diciplineID`) REFERENCES `sportDiciplines` (`sportDiciplineID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `personAwardsHistory`
--
ALTER TABLE `personAwardsHistory`
  ADD CONSTRAINT `personawardshistory_ibfk_3` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`),
  ADD CONSTRAINT `personawardshistory_ibfk_2` FOREIGN KEY (`awardID`) REFERENCES `personAwards` (`awardID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `personDiciplinesHistory`
--
ALTER TABLE `personDiciplinesHistory`
  ADD CONSTRAINT `persondiciplineshistory_ibfk_1` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `persondiciplineshistory_ibfk_2` FOREIGN KEY (`diciplineID`) REFERENCES `sportDiciplines` (`sportDiciplineID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `persondisqhstr`
--
ALTER TABLE `persondisqhstr`
  ADD CONSTRAINT `persondisqhstr_ibfk_1` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `personInfoHistory`
--
ALTER TABLE `personInfoHistory`
  ADD CONSTRAINT `personinfohistory_ibfk_1` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `personInjuriesHistory`
--
ALTER TABLE `personInjuriesHistory`
  ADD CONSTRAINT `personinjurieshistory_ibfk_2` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `personinjurieshistory_ibfk_1` FOREIGN KEY (`injuryID`) REFERENCES `personInjuries` (`injuryID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportapplications`
--
ALTER TABLE `sportapplications`
  ADD CONSTRAINT `sportapplications_ibfk_4` FOREIGN KEY (`countryID`) REFERENCES `countries` (`countryID`),
  ADD CONSTRAINT `sportapplications_ibfk_1` FOREIGN KEY (`parent_appID`) REFERENCES `sportapplications` (`applicationID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sportapplications_ibfk_2` FOREIGN KEY (`eventID`) REFERENCES `sportEvents` (`sportEventID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sportapplications_ibfk_3` FOREIGN KEY (`personID`) REFERENCES `persons` (`personID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportCompetitions`
--
ALTER TABLE `sportCompetitions`
  ADD CONSTRAINT `sportcompetitions_ibfk_1` FOREIGN KEY (`sportDiciplineID`) REFERENCES `sportDiciplines` (`sportDiciplineID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportDiciplines`
--
ALTER TABLE `sportDiciplines`
  ADD CONSTRAINT `sportdiciplines_ibfk_1` FOREIGN KEY (`sportKindID`) REFERENCES `sportKinds` (`sportKindsID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportEvents`
--
ALTER TABLE `sportEvents`
  ADD CONSTRAINT `sportevents_ibfk_2` FOREIGN KEY (`competitionPlaceID`) REFERENCES `sportObjectPlaces` (`sportObjectPlaceID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sportevents_ibfk_1` FOREIGN KEY (`competitionID`) REFERENCES `sportCompetitions` (`sportCompetitionID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportObjectAddresses`
--
ALTER TABLE `sportObjectAddresses`
  ADD CONSTRAINT `sportobjectaddresses_ibfk_2` FOREIGN KEY (`cityID`) REFERENCES `cities` (`cityID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `sportobjectaddresses_ibfk_1` FOREIGN KEY (`sportObjectID`) REFERENCES `sportObjects` (`sportObjectID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportObjectPlaces`
--
ALTER TABLE `sportObjectPlaces`
  ADD CONSTRAINT `sportobjectplaces_ibfk_1` FOREIGN KEY (`sportObjectID`) REFERENCES `sportObjects` (`sportObjectID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportObjects`
--
ALTER TABLE `sportObjects`
  ADD CONSTRAINT `sportobjects_ibfk_1` FOREIGN KEY (`olympicGamesID`) REFERENCES `olympicGames` (`olympicGameID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `sportResults`
--
ALTER TABLE `sportResults`
  ADD CONSTRAINT `sportresults_ibfk_1` FOREIGN KEY (`applicationID`) REFERENCES `sportapplications` (`applicationID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `tvChannelsBroadcasts`
--
ALTER TABLE `tvChannelsBroadcasts`
  ADD CONSTRAINT `tvchannelsbroadcasts_ibfk_2` FOREIGN KEY (`eventID`) REFERENCES `sportEvents` (`sportEventID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tvchannelsbroadcasts_ibfk_1` FOREIGN KEY (`tvChannelID`) REFERENCES `tvChannels` (`tvChannelID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `uRoleActions`
--
ALTER TABLE `uRoleActions`
  ADD CONSTRAINT `uroleactions_ibfk_2` FOREIGN KEY (`actionID`) REFERENCES `uActions` (`actionID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `uroleactions_ibfk_1` FOREIGN KEY (`roleID`) REFERENCES `uRoles` (`roleID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `userLanguage`
--
ALTER TABLE `userLanguage`
  ADD CONSTRAINT `userlanguage_ibfk_2` FOREIGN KEY (`languageID`) REFERENCES `uLanguages` (`languageID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `userlanguage_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `userRoles`
--
ALTER TABLE `userRoles`
  ADD CONSTRAINT `userroles_ibfk_2` FOREIGN KEY (`roleID`) REFERENCES `uRoles` (`roleID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `userroles_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON UPDATE CASCADE;

-- Ограничения внешнего ключа таблицы `weatherConditions`
--
ALTER TABLE `weatherConditions`
  ADD CONSTRAINT `weatherconditions_ibfk_1` FOREIGN KEY (`eventID`) REFERENCES `sportEvents` (`sportEventID`) ON UPDATE CASCADE;
