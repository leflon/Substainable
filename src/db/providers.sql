DELETE FROM SubscriptionProvider WHERE is_custom = 0;

INSERT INTO SubscriptionProvider VALUES('netflix', 'Netflix', '/providers/netflix.png', 0, NULL, 23);
INSERT INTO SubscriptionProvider VALUES('youtube', 'YouTube Premium', '/providers/youtube.png', 0, NULL, 13);
INSERT INTO SubscriptionProvider VALUES('prime_video', 'Prime Video', '/providers/prime_video.png', 0, NULL, 21);
INSERT INTO SubscriptionProvider VALUES('disney_plus', 'Disney+', '/providers/disney_plus.png', 0, NULL, 22);
INSERT INTO SubscriptionProvider VALUES('apple_tv_plus', 'Apple TV+', '/providers/apple_tv.png', 0, NULL, 19);

INSERT INTO SubscriptionProvider VALUES('spotify', 'Spotify Premium', '/providers/spotify.png', 0, NULL, 1);
INSERT INTO SubscriptionProvider VALUES('apple_music', 'Apple Music', '/providers/apple_music.png', 0, NULL, 1);
INSERT INTO SubscriptionProvider VALUES('deezer', 'Deezer', '/providers/deezer.png', 0, NULL, 1);

INSERT INTO SubscriptionProvider VALUES('icloud_plus', 'iCloud+', '/providers/icloud.png', 0, NULL, 2);
INSERT INTO SubscriptionProvider VALUES('microsoft_365', 'Microsoft 365', '/providers/microsoft_365.png', 0, NULL, 2);
INSERT INTO SubscriptionProvider VALUES('google_workspace', 'Google Workspace', '/providers/google_workspace.png', 0, NULL, 2);

INSERT INTO SubscriptionProvider VALUES('xbox_game_pass', 'Xbox Game Pass Ultimate', '/providers/xbox.png', 0, NULL, 28);
INSERT INTO SubscriptionProvider VALUES('playstation_plus', 'PlayStation Plus Premium', '/providers/playstation.png', 0, NULL, 26);
INSERT INTO SubscriptionProvider VALUES('geforce_now', 'NVIDIA GeForce NOW (Priority)', '/providers/geforce.png', 0, NULL, 41);

INSERT INTO SubscriptionProvider VALUES('nordvpn', 'NordVPN', '/providers/nordvpn.png', 0, NULL, 2);
INSERT INTO SubscriptionProvider VALUES('adobe_creative_cloud', 'Adobe Creative Cloud', '/providers/creative_cloud.png', 0, NULL, 6);
INSERT INTO SubscriptionProvider VALUES('notion', 'Notion Plus', '/providers/notion.png', 0, NULL, 1);
INSERT INTO SubscriptionProvider VALUES('chatgpt', 'ChatGPT Plus', '/providers/chatgpt.png', 0, NULL, 3);