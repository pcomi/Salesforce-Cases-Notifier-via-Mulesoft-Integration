const express = require("express")
const bodyParser = require("body-parser")
const path = require("path")

const app = express()
const PORT = process.env.PORT || 3000

let cases = []

app.use(bodyParser.json())
app.use(express.static(path.join(__dirname, "public")))

app.post("/case", (req, res) => {
	const newCase = {
		id: Date.now(),
		caseId: req.body.caseId,
		subject: req.body.caseSubject,
		priority: req.body.casePriority,
		status: req.body.caseStatus,
		origin: req.body.caseOrigin,
		owner: req.body.owner,
		ownerId: req.body.ownerId
	}

	///console.log("Received new case:", newCase)
	cases.push(newCase)

	res.json({ message: "Case received", case: newCase })
})

app.get("/cases", (req, res) => {
	res.json(cases)
})

app.listen(PORT, () => {
	console.log(`Server running`)
})
