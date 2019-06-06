($ => {
  const FILE_SIZE_LIMIT = 2 // 2mega
  $(() => {
    $(document)
      .on('click', '#photoBtn', () => {
        $('#photoInput').click()
      })
      .on('change', '#photoInput', ev => {
        const el = ev.currentTarget
        const file = el.files[0]
        if (file) {
          const fileSize = file.size
          if (fileSize > 1024 * 1024 * FILE_SIZE_LIMIT) {
            alert(`写真データを ${FILE_SIZE_LIMIT}m 以下にしてください！`)
            el.value = ''
          } else {
            let fileName = file.name
            if (fileName.length > 10) {
              const l = fileName.length
              fileName = '...' + fileName.substring(l - 10, l)
            }
            $('#photoBtn').text(fileName)
          }
        } else {
          $('#photoBtn').text('写真をアップ')
        }
      })
  })
})(jQuery)
