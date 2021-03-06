IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'fd_GetSubAutoJobTests' AND type = 'P')
   DROP PROCEDURE ipbased.fd_GetSubAutoJobTests
GO

CREATE procedure ipbased.fd_GetSubAutoJobTests
(
	@SubID INT
)
AS
	-- select up all jobs
	SELECT 
		j.*, u.username AS jobcreator, aj.name AS jobname,
		ea.zoneID, ea.zoneMod,
		ea.tool, ea.toolArguments,
		e.name, e.timeLimit, e.courseID, e.asstID, e.points
	FROM
		AutoJobTests j
	INNER JOIN
		EvaluationAuto ea ON ea.evalID = j.evalID
	INNER JOIN
		EvaluationsView e ON e.ID = j.evalID
	INNER JOIN
		AutoJobs aj ON aj.ID = j.jobID
	INNER JOIN 
		Users u ON u.principalID = aj.creatorID
	WHERE
		j.subID = @SubID
	ORDER BY
		j.jobID
GO