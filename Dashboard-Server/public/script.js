let lastCount = 0

async function fetchCases() 
{
	const res = await fetch("/cases")
	const cases = await res.json()
	renderCases(cases)
}

function renderCases(cases) 
{
	const container = document.getElementById("cases")
	container.innerHTML = ""

	cases.forEach(c => {
		const div = document.createElement("div")
		div.className = "case"
		div.innerHTML = `
			<h2>
				<a href="https://orgfarm-513a3d6ed7-dev-ed.develop.lightning.force.com/lightning/r/Case/${c.caseId}/view" target="_blank">
					${c.subject}
				</a> (Priority: ${c.priority})
			</h2>
			<p>Status: ${c.status}</p>
			<small>
				Origin: ${c.origin} | 
				Owner: <a href="https://orgfarm-513a3d6ed7-dev-ed.develop.lightning.force.com/lightning/r/User/${c.ownerId}/view" target="_blank">
					${c.owner}
				</a>
			</small>
		`
		container.appendChild(div)
	})

	if (cases.length > lastCount) 
    {
		const audio = document.getElementById("notify-sound")
		audio.play()
	}

	lastCount = cases.length
}

///check for new cases posted every second
setInterval(fetchCases, 1000)
fetchCases()
