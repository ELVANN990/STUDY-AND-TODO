<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enhanced Pomodoro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2ecc71;
            --secondary: #3498db;
            --background: #ffffff;
            --text: #2c3e50;
            --subtle: #f6f8fa;
            --accent: #e74c3c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            min-height: 100vh;
            background: var(--background);
            color: var(--text);
            display: flex;
            overflow-x: hidden;
        }

        .split-container {
            display: flex;
            width: 100vw;
            height: 100vh;
        }

        /* Timer Section */
        .timer-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            background: var(--subtle);
            position: relative;
        }

        .timer-display {
            font-size: 8rem;
            font-weight: 300;
            margin: 2rem 0;
            color: var(--text);
            font-variant-numeric: tabular-nums;
            letter-spacing: -2px;
            transition: color 0.3s ease;
        }

        .timer-status {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: color 0.3s ease;
        }

        /* Progress Bar */
        .progress-ring {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 400px;
        }

        .progress-ring circle {
            transition: stroke-dashoffset 0.35s;
            transform: rotate(-90deg);
            transform-origin: 50% 50%;
        }

        /* Stats Panel */
        .stats-panel {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: white;
            padding: 1rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .stats-item {
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        /* Motivation Quote */
        .motivation-quote {
            position: absolute;
            bottom: 8rem;
            text-align: center;
            font-style: italic;
            color: var(--text);
            opacity: 0.8;
            max-width: 80%;
        }

        /* Enhanced Settings Panel */
        .settings-panel {
            position: absolute;
            bottom: 2rem;
            display: flex;
            gap: 2rem;
            padding: 1.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
        }

        .settings-panel:hover {
            transform: translateY(-5px);
        }

        .setting-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        /* Enhanced Button Styles */
        button {
            padding: 1rem 2rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        .primary-btn {
            background: var(--primary);
            color: white;
        }

        .secondary-btn {
            background: var(--text);
            color: white;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        button::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        button:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }

            100% {
                transform: scale(100, 100);
                opacity: 0;
            }
        }

        /* Enhanced Input Styles */
        input[type="number"] {
            width: 80px;
            padding: 0.5rem;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        input[type="number"]:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .split-container {
                flex-direction: column;
            }

            .timer-section,
            .music-section {
                height: 50vh;
            }

            .timer-display {
                font-size: 6rem;
            }

            .progress-ring {
                width: 300px;
                height: 300px;
            }

            .settings-panel {
                position: relative;
                bottom: 0;
                margin-top: 2rem;
            }

            .stats-panel {
                position: relative;
                top: 0;
                right: 0;
                margin-bottom: 2rem;
            }
        }

        @media (max-width: 600px) {
            .timer-display {
                font-size: 4rem;
            }

            .progress-ring {
                width: 700px;
                height: 700px;
            }

            .settings-panel {
                flex-direction: column;
                gap: 1rem;
            }

            .spotify-container {
                max-width: 100%;
            }

            .stats-panel {
                width: 100%;
                margin: 1rem;
            }
        }
    </style>
</head>

<body>
    <div class="split-container">
        <section class="timer-section">
            <svg class="progress-ring" viewBox="0 0 100 100">
                <circle cx="50" cy="50" r="45" fill="none" stroke="#eee" stroke-width="5" />
                <circle id="progressRing" cx="50" cy="50" r="45" fill="none" stroke="var(--primary)" stroke-width="5"
                    stroke-dasharray="282.7" stroke-dashoffset="282.7" />
            </svg>
            <div class="stats-panel">
                <div class="stats-item">Sesi Selesai: <span id="completedSessions">0</span></div>
                <div class="stats-item">Total Fokus: <span id="totalFocusTime">0</span> menit</div>
                <div class="stats-item">Streak Harian: <span id="dailyStreak">0</span> hari</div>
            </div>

            <div class="timer-status" id="timerStatus">Ready to Focus</div>
            <div class="timer-display" id="timerDisplay">25:00</div>

            <div class="motivation-quote" id="motivationQuote"></div>

            <div class="timer-controls">
                <button class="primary-btn" id="startBtn">Start</button>
                <button class="secondary-btn" id="resetBtn">Reset</button>
            </div>

            <div class="settings-panel">
                <div class="setting-group">
                    <label for="workTime">Focus Time</label>
                    <input type="number" id="workTime" value="25" min="1" max="60">
                </div>
                <div class="setting-group">
                    <label for="breakTime">Break Time</label>
                    <input type="number" id="breakTime" value="5" min="1" max ```html="30">
                </div>
            </div>
        </section>

        <section class="music-section">
            <div class="spotify-container">
                <iframe src="https://open.spotify.com/embed/playlist/37i9dQZF1DX8NTLI2TtZa6?utm_source=generator"
                    width="100%" height="352" frameBorder="0" allowfullscreen
                    allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"
                    title="Spotify Playlist">
                </iframe>
            </div>
        </section>
    </div>

    <script>
        // Global variables
        let isRunning = false;
        let timeLeft = 25 * 60;
        let isWorkTime = true;
        let timerInterval;
        let totalSeconds;
        let stats = {
            completedSessions: 0,
            totalFocusTime: 0,
            dailyStreak: 0,
            lastCompleted: null
        };

        const motivationalQuotes = [
            "Fokus pada progres, bukan kesempurnaan.",
            "Setiap menit fokus adalah investasi untuk masa depanmu.",
            "Kualitas lebih baik daripada kuantitas.",
            "Satu langkah kecil setiap hari membawa perubahan besar.",
            "Disiplin adalah jembatan antara tujuan dan pencapaian."
        ];

        // DOM Elements
        const timerDisplay = document.getElementById('timerDisplay');
        const timerStatus = document.getElementById('timerStatus');
        const startBtn = document.getElementById('startBtn');
        const resetBtn = document.getElementById('resetBtn');
        const workTimeInput = document.getElementById('workTime');
        const breakTimeInput = document.getElementById('breakTime');
        const progressRing = document.getElementById('progressRing');
        const motivationQuote = document.getElementById('motivationQuote');
        const completedSessionsElement = document.getElementById('completedSessions');
        const totalFocusTimeElement = document.getElementById('totalFocusTime');
        const dailyStreakElement = document.getElementById('dailyStreak');

        // Load saved settings and stats
        function loadSettings() {
            const settings = JSON.parse(localStorage.getItem('pomodoroSettings') || '{}');
            const savedStats = JSON.parse(localStorage.getItem('pomodoroStats') || '{}');

            workTimeInput.value = settings.workTime || 25;
            breakTimeInput.value = settings.breakTime || 5;
            timeLeft = workTimeInput.value * 60;
            totalSeconds = timeLeft;

            stats = {
                ...stats,
                ...savedStats
            };

            updateStats();
            updateDisplay();
            updateMotivationalQuote();
        }

        // Save settings and stats
        function saveSettings() {
            const settings = {
                workTime: workTimeInput.value,
                breakTime: breakTimeInput.value
            };
            localStorage.setItem('pomodoroSettings', JSON.stringify(settings));
            localStorage.setItem('pomodoroStats', JSON.stringify(stats));
        }

        // Format time function
        function formatTime(seconds) {
            const minutes = Math.floor(seconds / 60);
            const remainingSeconds = seconds % 60;
            return `${String(minutes).padStart(2, '0')}:${String(remainingSeconds).padStart(2, '0')}`;
        }

        // Update progress ring
        function updateProgressRing() {
            const circumference = 2 * Math.PI * 45;
            const offset = circumference - (timeLeft / totalSeconds) * circumference;
            progressRing.style.strokeDasharray = `${circumference} ${circumference}`;
            progressRing.style.strokeDashoffset = offset;
        }

        // Update timer display
        function updateDisplay() {
            timerDisplay.textContent = formatTime(timeLeft);
            timerStatus.textContent = isWorkTime ? 'Focus Time' : 'Break Time';
            timerStatus.style.color = isWorkTime ? 'var(--primary)' : 'var(--secondary)';
            progressRing.style.stroke = isWorkTime ? 'var(--primary)' : 'var(--secondary)';
            updateProgressRing();
        }

        // Update stats display
        function updateStats() {
            completedSessionsElement.textContent = stats.completedSessions;
            totalFocusTimeElement.textContent = Math.round(stats.totalFocusTime / 60);
            dailyStreakElement.textContent = stats.dailyStreak;
        }

        // Update motivational quote
        function updateMotivationalQuote() {
            const randomQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
            motivationQuote.textContent = randomQuote;
        }

        // Check and update daily streak
        function updateDailyStreak() {
            const today = new Date().
            toDateString();

            if (stats.lastCompleted) {
                const lastDate = new Date(stats.lastCompleted);
                const dayDiff = Math.floor((new Date() - lastDate) / (1000 * 60 * 60 * 24));

                if (dayDiff > 1) {
                    stats.dailyStreak = 1;
                } else if (dayDiff === 1) {
                    stats.dailyStreak += 1;
                }
            } else {
                stats.dailyStreak = 1;
            }

            stats.lastCompleted = today;
            saveSettings();
        }

        // Timer functionality
        function startTimer() {
            if (!isRunning) {
                isRunning = true;
                startBtn.textContent = 'Pause';
                timerInterval = setInterval(() => {
                    timeLeft--;
                    updateDisplay();

                    if (timeLeft <= 0) {
                        playNotification();
                        if (isWorkTime) {
                            stats.completedSessions++;
                            stats.totalFocusTime += parseInt(workTimeInput.value);
                            updateDailyStreak();
                        }
                        isWorkTime = !isWorkTime;
                        timeLeft = isWorkTime ? workTimeInput.value * 60 : breakTimeInput.value * 60;
                        updateDisplay();
                        updateMotivationalQuote();
                    }
                }, 1000);
            } else {
                isRunning = false;
                startBtn.textContent = 'Resume';
                clearInterval(timerInterval);
            }
            saveSettings();
        }

        // Reset timer
        function resetTimer() {
            clearInterval(timerInterval);
            isRunning = false;
            timeLeft = workTimeInput.value * 60;
            isWorkTime = true;
            updateDisplay();
            startBtn.textContent = 'Start';
            saveSettings();
        }

        // Play notification sound
        function playNotification() {
            const audio = new Audio('notification.mp3');

            // Add event listener to handle errors
            audio.onerror = function () {
                console.error('Error: Unable to play the notification sound.');
            };

            // Load the audio file and play it
            audio.load();
            audio.play().catch(error => {
                console.error('Playback failed:', error);
            });
        }

        // Event listeners
        startBtn.addEventListener('click', startTimer);
        resetBtn.addEventListener('click', resetTimer);
        workTimeInput.addEventListener('change', () => {
            timeLeft = workTimeInput.value * 60;
            totalSeconds = timeLeft;
            updateDisplay();
            saveSettings();
        });
        breakTimeInput.addEventListener('change', () => {
            saveSettings();
        });

        // Load settings on window load
        window.onload = loadSettings;
    </script>
</body>

</html>