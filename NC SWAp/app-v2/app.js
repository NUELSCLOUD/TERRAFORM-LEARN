const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

// Middleware to log requests
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    version: '2.0',
    environment: 'green',
    timestamp: new Date().toISOString()
  });
});

// Main route
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
	<head>
		<title>Nwamu Emmanuel the DevOps Engineer Portfolio</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">

		<div id="wrapper" class="fade-in">

				<div id="intro">
						<h1>Nwamu Emmanuel<br />
						DevOps & CLOUD Engineer </h1>
						<p>A DevOps and Cloud Engineer dedicated to automating scale, 
						optimizing cloud costs, and bridging the gap between Dev and Ops. <a href="https://www.linkedin.com/in/nuelcruz36987/"></a></p>
						<ul class="actions">
							<!-- To add an accessabe name for the link in line 19, add the name inbetween the 2 inverted arrows after the kink  -->
							<li><a href="#header" class="button icon solid solo fa-arrow-down scrolly">Continue</a></li>
						</ul>
					</div>

				<header id="header">
						<a href="index.html" class="logo">EMMANUEL'S DEV</a>
					</header>

				<nav id="nav">
						<ul class="links">
							<li class="active"><a href="index.html">Projects</a></li>
						</ul>
						<ul class="icons">
							<li><a href="https://www.linkedin.com/in/nuelcruz36987/" class="icon brands alt fa-linkedin"><span class="label">Linkedin</span></a></li>
							<li><a href="https://github.com/NUELSCLOUD" class="icon brands alt fa-github"><span class="label">GitHub</span></a></li>
						</ul>
					</nav>

				<div id="main">

						<article class="post featured">
								<header class="major">
									<h2><a href="https://github.com/nuelcruz1/vprofile-jenkins-CI">CI/CD with Jenkins, Nexus, Sonarqube <br />
									and Slack</a></h2>
									<p>In this project I established a fully automated 'Shift Left' quality focused pipeline that ensures every release is validated against strict quality gates, securely versioned and provides developers with instant feedback in slack.</p>
								</header>
								<a href="https://github.com/nuelcruz1/vprofile-jenkins-CI" class="image main"><img src="images/C1.png" alt="" /></a>
								<ul class="actions special">
									<li><a href="https://github.com/nuelcruz1/vprofile-jenkins-CI" class="button large">view project</a></li>
								</ul>
							</article>

						<section class="posts">
								<article>
									<header>
										<h2><a href="https://github.com/nuelcruz1/SERVERLESS-APP">Serverless Web-App on AWS<br />
										</a></h2>
									</header>
									<a href="https://github.com/nuelcruz1/SERVERLESS-APP" class="image fit"><img src="images/c2.png" alt="" /></a>
									<p>This is a serverless web application hosted on AWS using the following services: Amazon S3, Amazon Cloudfront,AWS Route53, AWSLambda, Amazon API Gateway, Amazon DynamoDB, Amazon SNS</p>
									<ul class="actions special">
										<li><a href="https://github.com/nuelcruz1/SERVERLESS-APP" class="button">view project</a></li>
									</ul>
								</article>
								<article>
									<header>
										<h2><a href="https://github.com/nuelcruz1/vprofile-project-containerisation">Docker Containerization of an APP<br />
										</a></h2>
									</header>
									<a href="https://github.com/nuelcruz1/vprofile-project-containerisation" class="image fit"><img src="images/c3.png" alt="" /></a>
									<p>This project demonstrates the containerization of an application using Docker and Docker Compose.
									   </p>
									<ul class="actions special">
										<li><a href="https://github.com/nuelcruz1/vprofile-project-containerisation" class="button">view project</a></li>
									</ul>
								</article>
								<article>
									<header>
										<h2><a href="https://medium.com/@nwamuchuks4/re-architecting-my-vprofile-web-app-for-security-scale-and-efficiency-using-aws-services-f69e2c545673">Rearchitecting Web App using AWS Services<br />
										</a></h2>
									</header>
									<a href="https://medium.com/@nwamuchuks4/re-architecting-my-vprofile-web-app-for-security-scale-and-efficiency-using-aws-services-f69e2c545673" class="image fit"><img src="images/1758666408291.jpeg" alt="" /></a>
									<p>This is a web application hosted on AWS using the following services: Amazon S3, Amazon Cloudfront, AWS Route53, Application Load Balancer, Cloudwatch, Amazon RDS, Elastic cache, Amazon MQ, Elastic Beanstalk.</p>
									<ul class="actions special">
										<li><a href="https://medium.com/@nwamuchuks4/re-architecting-my-vprofile-web-app-for-security-scale-and-efficiency-using-aws-services-f69e2c545673" class="button">view project</a></li>
									</ul>
								</article>
							</section>
						</div>

					<footer id="footer">
						<section style="display: flex; flex-direction: column; align-items: center; text-align: center; width: 100%; padding: 4rem 0;">
							
							<div style="margin-bottom: 3rem; border: none; padding: 0;">
								<h3 style="margin: 0 0 0.75rem 0; font-size: 1.5rem; letter-spacing: 0.1em;">Location</h3>
								<p style="margin: 0; font-size: 1.25rem;">Asaba, Nigeria</p>
							</div>

							<div style="margin-bottom: 3rem; border: none; padding: 0;">
								<h3 style="margin: 0 0 0.75rem 0; font-size: 1.5rem; letter-spacing: 0.1em;">Phone</h3>
								<p style="margin: 0; font-size: 1.25rem;"><a href="tel:+2348136825006">(+234) 8136825006</a></p>
							</div>

							<div style="margin-bottom: 3rem; border: none; padding: 0;">
								<h3 style="margin: 0 0 0.75rem 0; font-size: 1.5rem; letter-spacing: 0.1em;">Email</h3>
								<p style="margin: 0; font-size: 1.25rem;"><a href="mailto:nwamuemmanuel@gmail.com">nwamuemmanuel@gmail.com</a></p>
							</div>

							<div style="border: none; padding: 0;">
								<h3 style="margin: 0 0 1.25rem 0; font-size: 1.5rem; letter-spacing: 0.1em;">Social</h3>
								<ul class="icons alt" style="display: flex; justify-content: center; list-style: none; padding: 0; margin: 0;">
									<li style="padding: 0 1.5rem;"><a href="https://www.linkedin.com/in/nuelcruz36987/" class="icon brands alt fa-linkedin" style="font-size: 1.5rem;"><span class="label">Linkedin</span></a></li>
									<li style="padding: 0 1.5rem;"><a href="https://github.com/NUELSCLOUD" class="icon brands alt fa-github" style="font-size: 1.5rem;"><span class="label">GitHub</span></a></li>
								</ul>
							</div>

						</section>
					</footer>

				<div id="copyright">
						<ul><li>&copy; Untitled</li><li>Design: <a href="https://html5up.net">HTML5 UP</a></li></ul>
					</div>

			</div>

		<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
    </html>
  `);
});

// New feature endpoint (only in v2.0)
app.get('/api/features', (req, res) => {
  res.json({
    version: '2.0',
    newFeatures: [
      {
        name: 'Modern UI',
        description: 'Complete redesign with modern aesthetics',
        status: 'completed'
      },
      {
        name: 'Performance Boost',
        description: '50% faster load times',
        status: 'completed'
      },
      {
        name: 'Advanced Analytics',
        description: 'Real-time insights and reporting',
        status: 'completed'
      }
    ]
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`✅ Application v2.0 (Green Environment) is running on port ${PORT}`);
  console.log(`🌐 Server started at ${new Date().toISOString()}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM signal received: closing HTTP server');
  process.exit(0);
});
